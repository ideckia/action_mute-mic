package;

using api.IdeckiaApi;

typedef Props = {
	@:editable("prop_muted_icon")
	var muted_icon:String;
	@:editable("prop_muted_color", 'ffaa0000')
	var muted_color:String;
	@:editable("prop_unmuted_icon")
	var unmuted_icon:String;
	@:editable("prop_unmuted_color", 'ff00aa00')
	var unmuted_color:String;
}

enum abstract System(String) from String {
	var Windows;
	var Linux;
	var Mac;
}

enum abstract MicAction(String) to String {
	var mute;
	var unmute;
}

@:name("mute-mic")
@:description("action_description")
@:localize
class MuteMic extends IdeckiaAction {
	var mutedIcon:String;
	var unmutedIcon:String;
	var isMuted:Bool;

	static public var system:System;

	override public function init(initialState:ItemState):js.lib.Promise<ItemState> {
		system = Sys.systemName();
		MuteLinux.init();
		MuteMac.init();
		MuteWindows.init();

		unmutedIcon = isBlank(props.unmuted_icon) ? Icons.getUnmuted() : props.unmuted_icon;
		mutedIcon = isBlank(props.muted_icon) ? Icons.getMuted() : props.muted_icon;
		isMuted = true;

		return executeAction(mute, initialState);
	}

	function isBlank(s:String)
		return s == null || StringTools.trim(s) == '';

	public function execute(currentState:ItemState):js.lib.Promise<ActionOutcome> {
		return new js.lib.Promise((resolve, reject) -> {
			executeAction((isMuted) ? unmute : mute, currentState).then(state -> resolve(new ActionOutcome({state: state}))).catchError(reject);
		});
	}

	function executeAction(action:MicAction, state:ItemState) {
		return new js.lib.Promise((resolve, reject) -> {
			var muteFunction = switch system {
				case Linux: MuteLinux.mute;
				case Mac: MuteMac.mute;
				case Windows: MuteWindows.mute;
				case x: throw 'Unknown system [$x]';
			}

			muteFunction(action).then(isMuted -> {
				this.isMuted = isMuted;
				state.bgColor = isMuted ? props.muted_color : props.unmuted_color;
				state.icon = isMuted ? mutedIcon : unmutedIcon;
				resolve(state);
			});
		});
	}
}
