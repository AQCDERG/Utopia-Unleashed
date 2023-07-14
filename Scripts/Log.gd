class_name Log

const TAB_PADDING_CHARS: int = 64;
const PADDING_TO_MESSAGE_SEPARATOR: String = " | ";

var _scriptNamespace: String;

func _init(script: Script):
	var realScript: Script = script as Script;
	var scriptPath: String = realScript.resource_path;
	_scriptNamespace = Log.ResourcePathToNamespace(scriptPath);

func info(arg1, arg2 = null, arg3 = null, arg4 = null, arg5 = null, arg6 = null, arg7 = null, arg8 = null, arg9 = null) -> void:
	var prefix: String = _GetPrefix("Info");
	var padding: String = _GetTabPadding(prefix.length()) + PADDING_TO_MESSAGE_SEPARATOR;
	var mushedMessage: String = _CreateMessage(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	
	var message: String = prefix + padding + mushedMessage;
	print(message);


func warn(arg1, arg2 = null, arg3 = null, arg4 = null, arg5 = null, arg6 = null, arg7 = null, arg8 = null, arg9 = null) -> void:
	var prefix: String = _GetPrefix("Warn");
	var padding: String = _GetTabPadding(prefix.length()) + PADDING_TO_MESSAGE_SEPARATOR;
	var mushedMessage: String = _CreateMessage(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	
	var message: String = prefix + padding + mushedMessage;
	push_warning(message);


func error(arg1, arg2 = null, arg3 = null, arg4 = null, arg5 = null, arg6 = null, arg7 = null, arg8 = null, arg9 = null) -> void:
	var prefix: String = _GetPrefix("Error");
	var padding: String = _GetTabPadding(prefix.length()) + PADDING_TO_MESSAGE_SEPARATOR;
	var mushedMessage: String = _CreateMessage(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	
	var message: String = prefix + padding + mushedMessage;
	push_error(message);


func _CreateMessage(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) -> String:
	var message: String = ""
	if arg1 != null:
		message = message + str(arg1);
	if arg2 != null:
		message = message + str(arg2);
	if arg3 != null:
		message = message + str(arg3);
	if arg4 != null:
		message = message + str(arg4);
	if arg5 != null:
		message = message + str(arg5);
	if arg6 != null:
		message = message + str(arg6);
	if arg7 != null:
		message = message + str(arg7);
	if arg8 != null:
		message = message + str(arg8);
	if arg9 != null:
		message = message + str(arg9);
	return message;

func _GetPrefix(level: String) -> String:
	return "[" + level + "][" + _scriptNamespace + "][" + str(Time.get_ticks_msec()) + "]";


func _GetTabPadding(prefixLength: int) -> String:
	var paddingLength: int = TAB_PADDING_CHARS - prefixLength;
	var paddingBuilder: String = "";
	for i in range(paddingLength):
		paddingBuilder = paddingBuilder + " ";
	return paddingBuilder;


static func ResourcePathToNamespace(filePath: String) -> String:
	const resourcePathPrefixLength: int = 6;
	filePath = filePath.substr(resourcePathPrefixLength);

	var parts: Array = filePath.split("/");
	var namespaceName: String = stringJoin(parts, ".");

	namespaceName = RemoveLastCharacter(namespaceName);

	return namespaceName;


static func stringJoin(array: Array, separator: String) -> String:
	var builder: String = "";
	for msg in array:
		builder = builder + str(msg) + separator;
	return builder;

static func RemoveLastCharacter(s: String) -> String:
	return s.substr(0, s.length() - 1);
