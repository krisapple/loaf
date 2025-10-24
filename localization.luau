localization = {
	["settings"] = {
		current=script.Parent:GetTags()[1],
		glm=function(str)
			if script.Parent:GetTags()[1] == "en" then
				if str ~= "LEFTQUOTE" and str ~= "RIGHTQUOTE" then
					return str
				else
					return '"'
				end
			end
			local t_str = localization[script.Parent:GetTags()[1]][str]
			if t_str == nil then return str .. " [LOCALIZATION FAIL]" end
			return t_str
		end,
	},
	
	["es"] = {
		--Special Characters
		["LEFTQUOTE"] = "«",
		["RIGHTQUOTE"] = "»",

		--main Module
		["DEBUG"] = "DEPURAR",
		["Initializing libraries."] = "Inicializando bibliotecas.",
		["Initializing library"] = "Inicializando biblioteca",
		["Finished"] = "Terminado",
		["Compression finished."] = "Compresión finalizada.",
		["Decompression finished."] = "Descompresión finalizada.",
		["Formatting finished."] = "Formateo finalizado.",
		["Creating new thread."] = "Creando un nuevo hilo.",
		["Running thread."] = "Hilo en curso.",
		["Performing decompression format tag check."] = "Realizando comprobación de etiqueta de formato de descompresión.",
		["Given string is not formatted, please format and try again."] = "La cadena proporcionada no está formateada. Por favor, formatee y vuelva a intentarlo.",
		["is not a valid variable for declarable."] = "no es una variable válida para declarable.",
		["is not a valid library. Skipping line."] = "no es una biblioteca válida. Saltando línea.",

		--Library specific
		["Runtime"] = "Tiempo de ejecución"
	},
	
	["de"] = {
		--Special Characters
		["LEFTQUOTE"] = "„",
		["RIGHTQUOTE"] = "“",
		
		--main Module
		["DEBUG"] = "DEBUGGEN",
		["Initializing libraries."] = "Bibliotheken initialisieren.",
		["Initializing library"] = "Initialisierung der Bibliothek",
		["Finished"] = "Fertig",
		["Compression finished."] = "Komprimierung abgeschlossen.",
		["Decompression finished."] = "Dekompression abgeschlossen.",
		["Formatting finished."] = "Formatierung abgeschlossen.",
		["Creating new thread."] = "Neuen Thread erstellen.",
		["Running thread."] = "Laufender Thread.",
		["Performing decompression format tag check."] = "Überprüfung des Dekompressionsformat-Tags durchführen.",
		["Given string is not formatted, please format and try again."] = "Die angegebene Zeichenfolge ist nicht formatiert. Bitte formatieren Sie sie und versuchen Sie es erneut.",
		["is not a valid variable for declarable."] = "ist keine gültige Variable für deklarierbare Variablen.",
		["is not a valid library. Skipping line."] = "ist keine gültige Bibliothek. Zeile wird übersprungen.",
		
		--Library specific
		["Runtime"] = "Laufzeit"
	},
	
	["fr"] = {
		--Special Characters
		["LEFTQUOTE"] = "«",
		["RIGHTQUOTE"] = "»",

		--main Module
		["DEBUG"] = "DÉBOGUER",
		["Initializing libraries."] = "Initialisation des bibliothèques.",
		["Initializing library"] = "Initialisation de la bibliothèque",
		["Finished"] = "Terminé",
		["Compression finished."] = "Compression terminée.",
		["Decompression finished."] = "Décompression terminée.",
		["Formatting finished."] = "Formatage terminé.",
		["Creating new thread."] = "Création d'un nouveau fil de discussion.",
		["Running thread."] = "Exécution du thread de code",
		["Performing decompression format tag check."] = "Vérification du format de décompression en cours.",
		["Given string is not formatted, please format and try again."] = "La chaîne fournie n'est pas formatée. Veuillez la formater et réessayer.",
		["is not a valid variable for declarable."] = "n'est pas une variable valide pour declarable.",
		["is not a valid library. Skipping line."] = "n'est pas une bibliothèque valide. Ignorer la ligne.",

		--Library specific
		["Runtime"] = "Durée d'exécution"
	},
	
	["ja"] = {
		--Special Characters
		["LEFTQUOTE"] = "「",
		["RIGHTQUOTE"] = "」",

		--main Module
		["DEBUG"] = "デバッグ",
		["Initializing libraries."] = "ライブラリの初期化中。",
		["Initializing library"] = "ライブラリの初期化",
		["Finished"] = "完了",
		["Compression finished."] = "圧縮が完了しました。",
		["Decompression finished."] = "減圧完了。",
		["Formatting finished."] = "書式設定が完了しました。",
		["Creating new thread."] = "新しいスレッドを作成します。",
		["Running thread."] = "スレッドを実行中。",
		["Performing decompression format tag check."] = "減圧フォーマットタグチェックを実行中。",
		["Given string is not formatted, please format and try again."] = "指定された文字列はフォーマットされていません。フォーマットして再度お試しください。",
		["is not a valid variable for declarable."] = "は宣言可能な有効な変数ではありません。",
		["is not a valid library. Skipping line."] = "は有効なライブラリではありません。行をスキップします。",

		--Library specific
		["Runtime"] = "実行時間"
	},
}

return localization
