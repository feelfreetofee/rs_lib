const frames = {}

const functions = {
    sendMessage(frameName, ...data) {
        frames[frameName]?.contentWindow?.postMessage(data, '*')
    },
    createFrame(frameName, url) {
        const frame = document.createElement('iframe')
        frame.name = frameName
		frame.src = url
        document.body.appendChild(frames[frameName] = frame)
		frame.contentWindow.GetParentResourceName = () => `${GetParentResourceName()}/${frameName}`
    },
    destroyFrame(frameName) {
        if (frameName in frames) {
            document.body.removeChild(frames[frameName])
            delete frames[frameName]
        }
    },

    showFrames() {
        document.body.style.removeProperty('display')
    },
    hideFrames() {
        document.body.style.display = 'hidden'
    },
    safeZone(size) {
        document.documentElement.style.setProperty('--safe-zone', (1 - size) * 10)
    }
}

window.addEventListener('message', ({data}) =>
    Array.isArray(data) &&
    functions[data.shift()]?.(...data)
)

fetch(`https://${GetParentResourceName()}/load`)
    .then(r => r.json())
    .then(({frames, safeZoneSize}) => {
        functions.safeZone(safeZoneSize)
        frames.forEach(([frameName, url]) =>
            functions.createFrame(frameName, url)
        )
    })