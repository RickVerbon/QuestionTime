from uuid import uuid4
from django.db import models
from core.models import TimeStampedModel
from django.conf import settings


class Question(TimeStampedModel):
    uuid = models.UUIDField(editable=False, default=uuid4)
    content = models.CharField(max_length=240)
    slug = models.SlugField(max_length=255, unique=True)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='questions')

    def __str__(self):
        return self.content


class Answer(TimeStampedModel):
    uuid = models.UUIDField(db_index=True, editable=False, default=uuid4)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    body = models.TextField()
    question = models.ForeignKey(Question, on_delete=models.CASCADE, related_name='answers')
    voters = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='likes')

    def __str__(self):
        return f"{self.author} - {self.question}"
