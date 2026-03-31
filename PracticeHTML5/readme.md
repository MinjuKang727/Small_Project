# HTML5 실습 사이트 개발

## 개발 동기
```
방송대 컴퓨터과학과 전공 강의를 들으며 실습을 할 때,
강의를 들으며 따로 Visual Studio Code에서 코드를 따라 쓰며 실습을 했는데 실습 코드만 따로 모아서 한번에 연습할 수 있는 사이트가 있으면 좋겠다는 생각이 들었습니다.
그래서 올해 수강 중인 HTML5 교재의 코드를 실습할 수 있는 사이트를 만들어 보게 되었습니다.
```

## 개발 하고 싶은 기능
1. 교재의 예제 실습   
    1) 실습 예제 관련 개념 설명
    2) 실습 예제 코드 제시  
    3) 실습 예제 코드 따라 쓰기  
    4) 실습 예제 코드 실행  
        i) 작성한 코드 실행 결과 보기  
        ii) 작성한 코드 오류 잡기  
2. 교재의 연습 문제 풀이

## 개발 내용

### 1. 교재의 예제 실습

#### 실습 페이지 구성  

- 구성
    - 설명
    - 예제 코드
    - 코드 작성 창
    - 실행 결과 창
- 조건 1: 가독성
![실습 페이지 구성: 왼쪽 상단 제목, 그 아래 왼쪽 반은 개념 설명 및 예제 코드, 오른쪽 반 중 위쪽은 코드 작성 공간 그 아래는 작성한 코드 실행 결과가 보이게 구성해 봄.](images/practice_page_design1.png)
- 2026.03.30 : 1차 완성
![실습 페이지 1차 완성본 사진](images/20230330_practicePage_ver1.png)
    - 트러블 슈팅💥
        1. **예제 코드에 raw code가 아닌 실행 결과가 보임**
            ![예제 코드에 raw code가 아닌 실행 결과가 보이는 사진](images/TroubleShooting_showRawTag1.png)

            - 원인: 예제 코드의 html 태그를 웹 페이지에서 그대로 출력하는 것이 아니라 html 문서의 태그로 인식하여 태그 실행 결과가 보이는 것이었음.

            - 1차 수정: <는 &lt;, >는 &gt;으로 변경
                > 결과: 태그를 텍스트로 출력 성공!  
                하지만 html문서는 줄바꿈이 인식되지 않으므로 줄바꿈으로 입력한 부분의 문장이 그대로 이어져서 출력됨.
                ![1차 수정 결과 사진](images/TroubleShooting_showRawTag2.png)

            - 2차 수정: 줄바꿈('\n')을 br태그(<br>)로 변경
                > 결과: 줄바꿈되게 출력 성공!  
                하지만 html태그에서 띄어쓰기를 인식하지 않아 탭이 제대로 출력되지 않음.
                ![2차 수정 결과 사진](images/TroubleShooting_showRawTag3.png)

            - 3차 수정: 띄어쓰기(' ')를 &nbsp;로 변경
                > 결과: 모든 입력 내용이 제대로 출력됨!
                ![3차 수정 결과 사진](images/TroubleShooting_showRawTag4.png)
        2. 코드 입력창을 단순한 Textarea가 아니라 선도 그어져 있고 줄 번호도 보이게 해서 Code editor처럼 만들고 싶었음.
            ![Textarea 처음 사진](images/TroubleShooting_DesignCodeEditor1.png)
            - 1차 수정: css에 아래 옵션을 줘서 배경 색 변경 및 선 추가
                <pre>background-color: rgb(22, 31, 37);
                    /* 선 넣기 핵심 CSS */
                    background-image: linear-gradient(#1b82ff 1px, transparent 1px);
                    background-size: 100% 20px; /* line-height와 동일하게 설정 */
                    background-position: 0 10px; /* 텍스트 높이에 맞게 조절 */
                    line-height: 20px; /* 줄 높이 */
                </pre>
                > 결과: 선이 예쁘게 생겼음!  
                하지만 코드가 길어져 스크롤 바를 내리면 선이 따라 올라가지 않아 코드와 선이 겹침

                ![1차 수정 결과 사진](images/TroubleShooting_DesignCodeEditor2.gif)

            - 2차 수정: background-attachment 옵션을 local로 설정
                <pre>background-attachment: local; /* 스크롤 시 배경도 같이 움직이도록 설정 */</pre>

                > 결과: 선이 스크롤을 올려도 따라서 잘 올라감.  
                이제 Textarea 왼쪽에 줄 번호를 추가하고 싶어짐.
                ![2차 수정 결과 사진](images/TroubleShooting_DesignCodeEditor3.gif)

            - 3차 수정: line_numbers 클래스의 div 추가,  
                <pre>// 줄번호 추가용 javascript
                $(document).ready(function() {
                    const textarea = document.querySelector('#input_code');
                    const lineNumbers = document.querySelector('.line_numbers');

                    textarea.addEventListener('input', () => {
                        const lines = textarea.value.split('\n').length;
                        lineNumbers.innerHTML = Array(lines).fill(0).map((_, i) => `<span>${i + 1}</span>`).join('<br>');
                    });

                    // 스크롤 동기화
                    textarea.addEventListener('scroll', () => {
                    lineNumbers.scrollTop = textarea.scrollTop;
                    });
                });

                /* 줄 번호 css \*/
                .line_numbers {
                width: 15px;
                background-color: #d1e4ff;
                padding: 10px;
                text-align: right;
                color: rgb(41, 105, 194);
                font-family: monospace;
                font-size: 15px;
                line-height: 20px;
                user-select: none; /* 줄 번호 선택 방지 */
                overflow: auto;
                scrollbar-width: none;
                }

                &lt;!--&nbsp;html&nbsp;태그&nbsp;--&gt;<br>&lt;div&nbsp;class="code_editor"&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&lt;div&nbsp;class="line_numbers"&gt;&lt;span&gt;1&lt;/span&gt;&lt;/div&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&lt;textarea&nbsp;class="input_code"&nbsp;id="input_code"&nbsp;name="input_code"&nbsp;placeholder="여기에&nbsp;코드를&nbsp;입력하세요"&gt;&lt;/textarea&gt;<br>&lt;/div&gt;</pre>

                > 결과: 왼쪽에 줄번호가 잘 추가됨.  
                하지만 Tab키로 들여쓰기 및 내어쓰기가 되지 않아 스페이스바로 들여쓰기를 해야함.
                ![3차 수정 결과 사진](images/TroubleShooting_DesignCodeEditor4.gif)

            - 4차 수정: JQuery를 이용하여 들여쓰기, 내어쓰기 기능 구현    
                <pre>$(document).ready(function() {
                $('#input_code').on('input', function(e) {
                    const value = $(this).val();
                    const lines = value.split('\n').length;
                    $('.line_numbers').html(Array(lines).fill(0).map((_, i) => `<span>${i + 1}</span>`).join('<br>'));
                });

                // 스크롤 동기화
                \$('#input_code').scroll(function() {
                    \$('.line_numbers').scrollTop($(this).scrollTop());
                });

                \$('#input_code').keydown(function(e) {
                    if (e.shiftKey && e.keyCode === 9) {  // Shift 키가 눌렸을 때 (keyCode 16)
                        e.preventDefault();  // 포커스 이동 막기
                        let start = \$(this).get(0).selectionStart;
                        let end = \$(this).get(0).selectionEnd;
                        let value = \$(this).val();
                        let lineStart = value.lastIndexOf('\n', start - 1) + 1;

                // 내어쓰기 로직
                for (let i = 4; i > 0; i--) {
                    if (value.substring(lineStart, lineStart + i) === ' '.repeat(i)) {
                        \$(this).val(value.substring(0, lineStart) + value.substring(lineStart + i));
                        \$(this).get(0).selectionStart = $(this).get(0).selectionEnd = start - i;
                        break;
                    }
                }
                    } else if (e.keyCode === 9) {
                        e.preventDefault();  // 포커스 이동 막기
                        let value = \$(this).val();
                        let start = \$(this).get(0).selectionStart;
                        let end = \$(this).get(0).selectionEnd;
                        const indent = "    ";
                        
                \$(this).val(value.substring(0, start) + indent + value.substring(end))
                \$(this).get(0).selectionStart = \$(this).get(0).selectionEnd = start + indent.length;
                    }
                });
            });</pre>

                > 결과: 'Tab' 키를 눌러 들여쓰기, 'Shift' + 'Tab' 키로 내어쓰기 기능 구현  
                하지만 윗줄의 들여쓰기가 아랫줄에 이어지지 않음.  
                ![4차 수정 결과 사진](images/TroubleShooting_DesignCodeEditor5.gif)

            - 5차 수정: 자동 들여쓰기를 JQuery로 구현
                <pre>$('#input_code').keydown(function(e) {
                    if (e.keyCode === 13) {  // keyCode: 13(Enter키)
                    // 자동 들여쓰기
                    let start = $(this).get(0).selectionStart;
                    let end = $(this).get(0).selectionEnd;
                    let prevLineStart = value.lastIndexOf('\n', start - 2) + 1;
                    let prevLine = value.substring(prevLineStart, start - 1);
                    let indentSize = prevLine.match(/^\s*/)[0].length;
                    let indent = " ".repeat(indentSize);
                    $(this).val(value.substring(0, start) + indent + value.substring(end))
                    $(this).get(0).selectionStart = $(this).get(0).selectionEnd = start + indent.length;
                }
                });</pre>

                > 결과: 윗줄의 들여쓰기되어 있는 만큼 아랫줄에도 자동으로 들여쓰기 되도록 함.  
                ![5차 수정 결과 사진](images/TroubleShooting_DesignCodeEditor6.gif)

            - 기타 수정: CodeMirror를 이용한 CodeEditor 구현  

                <pre>// CodeMirror 적용 javascript
                var MyCodeMirror; // CodeMirror 인스턴스를 전역 변수로 선언
                $(document).ready(function() {

                    // CodeMirror 초기화
                    myCodeMirror  =  CodeMirror.fromTextArea ( document.getElementById("input_code"),  {
                        lineNumbers :  true , // 줄 번호 표시
                        matchBrackets :  true , // 괄호 자동 매칭
                        styleActiveLine :  true , // 현재 줄 강조
                        lineWrapping :  true, // 긴 줄 자동 줄바꿈
                        mode :  "htmlmixed" , // HTML 모드 설정
                        theme :  "default" , // 테마 설정 (원하는 테마로 변경 가능)
                        indentUnit :  4 , // 들여쓰기 단위 설정
                        tabSize :  4 , // 탭 크기 설정
                    } ) ;
                    });

                    function changeTheme() {
                        var selectedTheme = $("#theme_selector").val();
                        myCodeMirror.setOption("theme", selectedTheme);
                    };

                &lt;!-- body의 Textarea --&gt;
                &lt;textarea id="input_code" name="input_code" placeholder="여기에 코드를 입력하세요"&gt;&lt;/textarea&gt;
                </pre>

                > 결과: 앞의 3차 수정까지 구현했을 때 CodeMirror를 알게되었습니다. Textarea에 CodeMirror를 적용하고 테마 변경 가능하도록 했었는데 줄 번호만 보이고 선은 보이지 않는 점이 만족스럽지 않았었습니다.  
                이후 트러블 슈팅을 작성하던 중에 '이왕 구현했던 거 조금만 더 다시 구현해 볼까?'라는 생각이 들어 앞의 5차 수정까지 구현하게된 것인데  
                CodeMirror가 테마 변경도 가능하고 태그와 텍스트의 색도 구별이 되어 가독성이 좋았지만
                제가 직접 구현한 것이 줄번호, 선도 보이고 들여쓰기, 내어쓰기, 자동 들여쓰기 기능까지 구현되어서 CodeMirror 대신 제가 구현한 것을 쓰기로 결정하였습니다.
                ![5차 수정 결과 사진](images/TroubleShooting_DesignCodeEditor6.gif)



#### 데이터 업로드 및 수정 페이지 구성
> 개발을 하며 일일이 데이터를 입력 및 저장하는 것이 번거로울 것 같아서 편집 페이지를 만들게 되었습니다.

1. 

