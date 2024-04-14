## App sample
![제목 없는 동영상 - Clipchamp로 제작](https://github.com/choikanghoon/mmd/assets/149549379/edc486ee-4c2e-4a9f-b759-f547d3c16688)
![제목 없는 동영상 - Clipchamp로 제작 (1)](https://github.com/choikanghoon/mmd/assets/149549379/16573c26-88d8-4026-8f6c-7dbdfd2207a5)



## Project Background  
![4](https://github.com/choikanghoon/mmd/assets/149550120/53304af5-e5e3-41be-a6f2-a91e7f95d918)
![5](https://github.com/choikanghoon/mmd/assets/149550120/397cc201-6a84-47c0-953e-8633b8e0f4cd)

The COVID-19 pandemic that began in 2020 has reduced the opportunities for children to be exposed to language, resulting in delays in children's language development. However, as child language development plays a crucial role in children's communication skills and interaction, we aimed to develop an app that can provide children with various language stimuli and contribute to the development of their language abilities.

## Development Purpose
![6](https://github.com/choikanghoon/mmd/assets/149550120/2bb61a0b-428c-4042-a98b-dcaf14908e90)


Through the app, children can become familiar with Korean alphabet (Hangul) from an early age, which can prevent the decline in literacy skills as they grow older. Additionally, the app can help 4 to 7-year-old children, who are naturally curious, to develop a self-directed learning approach by using the app to satisfy their curiosity.
This process can eliminate any aversion to learning Hangul and help children form familiarity with the Korean alphabet.

## APP UI / UX
![mmd_design](https://github.com/choikanghoon/mmd/assets/149554171/8ef2c56b-5682-4f38-bf5b-63220272ef28)


5. 모델 ( 기술스택 등 ) Flutter Server Model 조직도 등등 - 민기님이 정리한내용 좀 스크립트를 넣으면되고 + 프론트엔드 이야기 정도?

## AI Model(Clip, TTS, Gemini+RAG)

### Clip
#### Clip Model Test Result : 129 Class / Accuracy 86.7%
![clip_result](_AI_model/clip_result.png)

#### ★ How Can We use well, Select well-learned English words
![image](https://github.com/choikanghoon/mmd/assets/89675001/46c918bb-1436-43e3-9c64-d02f76fdf916)

### RAG
#### RAG + Gemini Result
![rag_result](_AI_model/rag_result.png)

##### ★ Vector DB 구조
![rag_vectordb](_AI_model/rag_vectordb.png)

##### ★ Prompt Engineering
```python
template = """Make three quizs for {years} years old kids and return list like '[json, json, json]'.

Quiz format rule:
- one right answer.
- three options.
- Use careful terms that fit the Korean sentence and Use honorifics.
- Options sentence must be short for kid

Making quiz tips
- Based on below context.
- Don't care about the time order of the context.
- Use the peripheral part and the whole context together.
- Don't use NEGLIGIBLE word.

json format: 
"question" : "quiz",
"options" : ["option1","option2","option3"],
"answer" : 0

context:
{context}

{again}
"""
```

5. 셋팅에 필요한 요소 - 무슨 API를 썼고 무슨 값을 넣어야하는지 대충 (코드에있는 내용 대충 써주기)
