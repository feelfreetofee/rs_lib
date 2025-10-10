const list = {
    show(index = 0, length = 0, title = '', description) {
        this.hide()

        const element = document.createElement('div')
        element.innerHTML = `<div>${title} ${index}/${length}</div>`
        if (description)
            element.innerHTML += `<div>${description}</div>`
        if (index > 1)
            element.classList.add('back')
        if (index < length)
            element.classList.add('forward')

        this.show.element = document.body.appendChild(element)
    },
    hide() {
        this.show.element?.remove()
    }
}

window.addEventListener('message', ({data}) => list[data.shift()]?.(...data))