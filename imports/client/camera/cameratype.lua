---@enum cameraType
local CameraType = {
	scripted = 'DEFAULT_SCRIPTED_CAMERA',
	scriptedFly = 'DEFAULT_SCRIPTED_FLY_CAMERA', -- An in-game fly camera designed for use in the mission creator
	animated = 'DEFAULT_ANIMATED_CAMERA',
	transition = 'DEFAULT_TRANSITION_CAMERA',
	splineDefault = 'DEFAULT_SPLINE_CAMERA', -- smoothed and velocity constrained spline, not continous velocity
	splineTimed = 'TIMED_SPLINE_CAMERA', -- smoothed and velocity constrained spline, not continous velocity
	splineRounded = 'ROUNDED_SPLINE_CAMERA', -- rounded spline with continous velocity
	splineSmoothed = 'SMOOTHED_SPLINE_CAMERA', -- smoothed spline with continous velocity
	splineTimedCustom = 'CUSTOM_TIMED_SPLINE_CAMERA' -- smoothed and velocity constrained spline, not continous velocity, custom speeds can be set
}

return CameraType