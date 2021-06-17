// Javascriptで呼ぶためのAPI例

const API = class {
    constructor(){}
    removeIdentifier(propertyKey) {
	// プロパティ（Part-of概念＋Attribute概念のロール名は，識別子として末尾に「_#数字」を付与している
	// 実際に完全一致検索をするなら，文字列からこれを取り除かねばならない
	// それ用のUtility
	return propertyKey.substring(0, propertyKey.indexOf("_#"))
    }

    getConcept(conceptName) {
	// URLにアクセスしてJSONを取得する基盤API部分
	const url = `http://localhost:5050/concept-name/${conceptName}`;
	return fetch(url, {
	    mode: 'cors'
	}).then((res) => {
	    return res.json();
	}).then((data) => {
	    return data;
	}).catch((err) => {
	    return err;
	});
    }

    // 「サブ認知活動」というロールのスロットが複数ヒットする
    // システムは自動で_#1,_#2を入れるので，これが無い状態でヒットするものだけを抽出
    subActivities(basicConceptName, roleName, callback) {
	getConcept(basicConceptName).then(res => {
	    const propertyKeys = Object.keys(res.properties)
	    const targetKeys = propertyKeys.filter(prop => removeIdentifier(prop) === roleName)
	    callback(targetKeys.map(r => res.properties[r]))
	})
    }
}


//以下，使用例(研究に関する認知活動の一種（研究する）のサブ活動一覧を取得し，それぞれのオントロジーノードIDを得るコード)
// 入力は，第1引数（基本概念名），第2引数（ロール概念名）
const api = new API();
api.subActivities("研究する", "サブ認知活動", res => {
    res.map(c => {
	api.getConcept(c).then(r => {
	    console.log(`${r['concept-name']}=>${r['id']}`)
	})
    })
})

/*
// これを実行すると，結果，以下のような出力を得る
問題を発見する => 509010690559_n201
研究目的を設定する => 1509010690559_n184
課題を設定する => 1509010690559_n207
課題を解決する => 1509010690559_n212
論文に落とし込む => 1509010690559_n218
*/
