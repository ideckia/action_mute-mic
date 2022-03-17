import MuteMic.MicAction;

class MuteMac {
	static public function init() {
		if (MuteMic.system != Mac)
			return;
	}

	static public function mute(action:MicAction):js.lib.Promise<Bool> {
		return new js.lib.Promise((resolve, _) -> {
			inline function setVolume(vol) {
				runOsascript('set volume input volume ${Std.string(vol)}');
				resolve(action == MicAction.mute);
			}

			switch action {
				case MicAction.mute: setVolume(0);
				case MicAction.unmute: setVolume(100);
			}
		});
	}

	static function runOsascript(args:String) {
		js.node.ChildProcess.spawn('osascript', ['-e', args]);
	}
}
