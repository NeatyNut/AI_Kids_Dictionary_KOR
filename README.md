![setting방법](https://github.com/choikanghoon/mmd/assets/89675001/a3184e47-35eb-4563-89b2-af6d6c5d637a)## App sample
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


## AI Model(Clip, TTS, Gemini+RAG)

### Clip
#### Clip Model Test Result : 129 Class / Accuracy 86.7%
We built an api that receives classes flexibly so that classes can be added at any time to maximize the performance of the Clip model. Experiments with test data collected directly from 129 classes resulted in 86.7% accuracy.
- experimental data : [Click](https://github.com/choikanghoon/mmd/blob/main/_AI_model/clip/model_test/%ED%81%B4%EB%A6%BD%20%EB%AA%A8%EB%8D%B8%20%ED%85%8C%EC%8A%A4%ED%8A%B8%20%EA%B2%B0%EA%B3%BC.csv)
- test_data : [Click](https://github.com/choikanghoon/mmd/tree/main/_AI_model/clip/model_test/data)
- note : [Click](https://github.com/choikanghoon/mmd/blob/main/_AI_model/clip/clip%20%EC%97%B0%EA%B5%AC%EC%9A%A9.ipynb)
![model_test](https://github.com/choikanghoon/mmd/assets/149554171/bc69fc9f-1df1-418d-bad0-c4469787ba3b)


#### ★ How Can We use well, Select well-learned English words
To make the most of the performance of Clip, we tested which words were well learned. The results are as follows.
- experimental data : [Click](https://github.com/choikanghoon/mmd/blob/main/_AI_model/clip/eng_crawling/eng_crawling_result.csv)
- note : [Click](https://github.com/choikanghoon/mmd/blob/main/_AI_model/clip/eng_crawling/crawling.ipynb)
![image](https://github.com/choikanghoon/mmd/assets/89675001/46c918bb-1436-43e3-9c64-d02f76fdf916)

### RAG
#### RAG + Gemini Result
We were able to create a quiz generation ai that significantly reduced Hallucination by constructing a Vector DB and using RAG to generate Korean traditional fairy tales as quizzes.
- note : [Click](https://github.com/choikanghoon/mmd/blob/main/_AI_model/rag/RAG%20%EC%97%B0%EA%B5%AC%EC%9A%A9.ipynb)
- book_txt : [Click](https://github.com/choikanghoon/mmd/tree/main/_AI_model/rag/book_data/book_txt)
![model_test2](https://github.com/choikanghoon/mmd/assets/149554171/b0f03380-7462-4247-865b-ac876b09612b)


##### ★ Vector DB 구조
VectorDB was used as an index for children's books.
- DB : [Click](https://github.com/choikanghoon/mmd/blob/main/_AI_model/rag/book_data/chroma.sqlite3)

![model_ vectorDB](https://github.com/choikanghoon/mmd/assets/149554171/b31548b4-d14d-4341-9357-15e770cde4d5)


##### ★ Prompt Engineering
By providing various prompts, including one-shot prompts, a quiz was obtained in the form of json and implemented at the app level without difficulty.
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

## How You Can use(Setting reference)
- setting.dart : [Click]()
![setting방법](https://github.com/choikanghoon/mmd/assets/89675001/ca403bdb-362f-4b49-b745-c4061cede0cf)

