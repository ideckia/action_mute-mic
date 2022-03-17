package;

using api.IdeckiaApi;

typedef Props = {
	@:editable("Muted icon in base64")
	var mutedIcon:String;
	@:editable("Muted color", 'ffaa0000')
	var mutedColor:String;
	@:editable("Unmuted icon in base64")
	var unmutedIcon:String;
	@:editable("Unmuted color", 'ff00aa00')
	var unmutedColor:String;
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
@:description("Mute / unmute system microphone")
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

		unmutedIcon = props.unmutedIcon == null ? Icons.getUnmuted() : props.unmutedIcon;
		mutedIcon = props.mutedIcon == null ? Icons.getMuted() : props.mutedIcon;
		isMuted = true;

		return executeAction(mute, initialState);
	}

	public function execute(currentState:ItemState):js.lib.Promise<ItemState> {
		return executeAction((isMuted) ? unmute : mute, currentState);
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
				state.bgColor = isMuted ? props.mutedColor : props.unmutedColor;
				state.icon = isMuted ? mutedIcon : unmutedIcon;
				resolve(state);
			});
		});
	}
}
