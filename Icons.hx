import haxe.Exception;
import haxe.macro.TypeTools;
import haxe.macro.Expr.ExprOf;

class Icons {
	static public function getUnmuted() {
		return getIcon('unmuted.png');
	}

	static public function getMuted() {
		return getIcon('muted.png');
	}

	static public macro function getIcon(iconNameExpr:ExprOf<String>) {
		var iconName = haxe.macro.ExprTools.getValue(iconNameExpr);
		var encoded = "";
		try {
			var bytes = sys.io.File.getBytes(Sys.getCwd() + '/' + iconName);
			encoded = haxe.crypto.Base64.encode(bytes);
		} catch (e:haxe.Exception) {
			trace(e);
		}
		return {expr: EConst(CString(encoded)), pos: haxe.macro.Context.currentPos()};
	}
}
