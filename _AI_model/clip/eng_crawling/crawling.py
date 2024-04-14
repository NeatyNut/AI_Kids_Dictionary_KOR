import pandas as pd

# 데이터
df = pd.read_csv("라벨.csv", encoding='cp949')

# 표제어
query_list = list(df['표제어'])

# 클래스 리스트
class_list = []
for i in range(len(df)):
    class_list.append(list(df.iloc[i][2:].dropna()))

#####
from transformers import CLIPProcessor, CLIPModel
from PIL import Image
import requests
from io import BytesIO

# CLIP 모델과 프로세서 로드
processor = CLIPProcessor.from_pretrained("openai/clip-vit-base-patch32")
clip_model = CLIPModel.from_pretrained("openai/clip-vit-base-patch32")

# 이미지 경로와 텍스트 레이블 목록을 받아서, 이미지에 가장 적합한 텍스트 레이블을 예측합니다.
def predict_text_from_image(image_url, text_labels):
    # 이미지 로드 및 전처리
    response = requests.get(image_url)
    image = Image.open(BytesIO(response.content))
    inputs = processor(text=text_labels, images=image, return_tensors="pt", padding=True)

    # 모델을 통해 이미지와 텍스트의 유사도 계산
    outputs = clip_model(**inputs)
    logits_per_image = outputs.logits_per_image # 이미지에 대한 로짓

    # 수정 후
    probs = logits_per_image.softmax(dim=1).detach().cpu().numpy()

    # 가장 높은 확률을 가진 텍스트 레이블을 찾음
    # max_index = probs.argmax()
    # predicted_label = text_labels[max_index]

    return probs[0].tolist()

import requests
from bs4 import BeautifulSoup

def crawl(query, labels) :
    crawl_list = []
    url = 'https://www.google.com/search?sca_esv=2e034f13424ae33d&q=' + query + '&tbm=isch&source=lnms&sa=X&ved=2ahUKEwjTlIyLu8CEAxUfjVYBHVNEARoQ0pQJegQIDhAB&biw=1600&bih=927&dpr=1.56'
    response = requests.get(url)

    if response.status_code == 200:
        html = response.text
        soup = BeautifulSoup(html, 'html.parser')
    
        for jdx, j in enumerate(soup.find_all('img')) :
            if jdx == 0 :
                continue
            probs = predict_text_from_image(j['src'], labels)
            crawl_list.append({'url' : j['src'], 'probs' : probs})
            
        return crawl_list
    

def make_dict(result:list, index:int, query:str, labels:list):
    crawl_list = crawl(query, labels)

    for i in crawl_list :
        url = i['url']
        probs = i['probs']
        result.append({'query' : query, 'url' : url, 'labels' : labels, 'probs': probs})
    return result

df2 = pd.DataFrame(data=[], columns=["index", "url", "표제어", "단어1", "단어2", "단어3", "단어4", "단어5", "단어6", "단어7", "단어8", "단어9", "단어10", "단어11", "단어12", "확률1", "확률2", "확률3", "확률4", "확률5", "확률6", "확률7", "확률8", "확률9", "확률10", "확률11", "확률12"])


y = 0
all_number = len(query_list)

for idx, i in enumerate(class_list) :
    if idx > 627 :
        break
    
    if len(i) > 1 :
        result = []
        try :
            result = make_dict(result, idx+2, query_list[idx], i)
            for j in result :
                dict = {}
                dict["index"] = idx+2
                dict["url"] = j["url"]
                dict["표제어"] = j['query']
                

                for x_idx, x in enumerate(j['labels']) :
                    dict_key1 = "단어" + str(int(x_idx + 1))
                    dict_key2 = "확률" + str(int(x_idx + 1))

                    dict[dict_key1] = x
                    dict[dict_key2] = j['probs'][x_idx]
            
                df2.loc[y] = pd.Series(dict)
                y += 1
        except:
            print(f"{i}는 오류")

    df2.to_csv("결과.csv", encoding='cp949')            
    print(f"진행 상황 : {round(((idx+1)/all_number)*100,1)}%")