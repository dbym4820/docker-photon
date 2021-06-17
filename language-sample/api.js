// Javascriptで呼ぶためのAPI例

function getPartOfConcept(conceptName) {
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

/* 以下，使用例

getPartOfConcept("メタ認知活動").then(res => {
    console.log(res);
});

*/
