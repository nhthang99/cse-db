from django import forms  
from news.models import NewsModel

class NewsForm(forms.ModelForm):  
    class Meta:  
        model = NewsModel  
        fields = "__all__" 