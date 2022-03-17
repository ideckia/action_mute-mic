import MuteMic.MicAction;

class MuteWindows {
	static public function init() {
		if (MuteMic.system != Windows)
			return;
	}

	static public function mute(action:MicAction):js.lib.Promise<Bool> {
		return new js.lib.Promise((resolve, _) -> {
			var response = js.node.ChildProcess.spawnSync(js.Node.__dirname + '/mute-win.exe', ['--${action}']);
			resolve(response.status == 1);
		});
	}
}
