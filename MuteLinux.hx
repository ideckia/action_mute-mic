import MuteMic.MicAction;

class MuteLinux {
	static var useAmixer:Bool;

	static public function init() {
		if (MuteMic.system != Linux)
			return;

		js.node.ChildProcess.exec('pactl info', (error, _, _) -> useAmixer = error != null);
	}

	static public function mute(action:MicAction):js.lib.Promise<Bool> {
		return new js.lib.Promise((resolve, _) -> {
			if (useAmixer) {
				js.node.ChildProcess.spawn('amixer set Mic $action');
			} else {
				var actionValue = switch action {
					case MicAction.mute:
						'1';
					case MicAction.unmute:
						'0';
				}
				js.node.ChildProcess.spawn('pactl', ['set-source-mute', '@DEFAULT_SOURCE@', actionValue]);
			}

			resolve(action == MicAction.mute);
		});
	}
}
