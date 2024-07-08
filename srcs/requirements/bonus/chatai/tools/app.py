import streamlit as st
from transformers import GPT2LMHeadModel, GPT2Tokenizer

model_name = "gpt2-medium"
model = GPT2LMHeadModel.from_pretrained(model_name)
tokenizer = GPT2Tokenizer.from_pretrained(model_name)

def generate_response(prompt):
    inputs = tokenizer.encode(prompt, return_tensors="pt")
    outputs = model.generate(
        inputs,
        max_length=150,
        num_return_sequences=1,
        no_repeat_ngram_size=3,
        early_stopping=True,
        temperature=0.7,
        top_p=0.9,
        top_k=50
    )
    response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return response.strip()

st.set_page_config(
        page_title="Stupid Chatbot",
)
st.title("Stupid Chatbot")
st.write("This is a simple GPT-2 powered chatbot. Ask anything!")

user_input = st.text_input("You: ")

if st.button("Send") and user_input:
    response = generate_response(user_input)
    st.write(f"Bot: {response}")
