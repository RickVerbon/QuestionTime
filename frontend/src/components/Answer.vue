<template>
  <div>
    <p class="text-muted">
      <strong>{{ answer.author }} &#8901;{{ answer.created_at }}</strong>
    </p>
      <p style="white-space: pre-wrap"> {{ answer.body }}</p>
    <div v-if="isAnswerAuthor">
      <router-link class="btn btn-sm btn-warning" :to="{name: 'answer-editor', params: {uuid: answer.uuid}}">
        Edit
      </router-link>
      <button @click="showDeleteConfirmationButton = !showDeleteConfirmationButton" class="btn btn-sm btn-danger mx-1">
        Delete
      </button>
      <button v-show="showDeleteConfirmationButton" @click="triggerDeleteAnswer" class="btn btn-sm btn-outline-danger">
        Yes, delete my answer
      </button>
    </div>
    <div v-else>
      <button @click="toggleLike" class="btn"
              :class="{'btn-warning': userLikedAnswer,
                       'btn-outline-danger': !userLikedAnswer}">
        {{ userLikedAnswer ? "Unlike answer" : "Like answer"}}
        <span class="badge bg-danger">{{ likesCounter }}</span>
      </button>
    </div>
    <hr />
  </div>

</template>


<script>
import { axios } from "@/common/api.service";
export default {
  emits: ['delete-answer'],
    name: "AnswerComponent",
  props: {
    answer: {
      type: Object,
      required: true
    },
    requestUser: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      userLikedAnswer: this.answer.user_has_liked_answer,
      likesCounter: this.answer.likes_count,
      showDeleteConfirmationButton: false
    }
  },
  computed: {
    isAnswerAuthor() {
      return this.answer.author === this.requestUser
    }
  },
  methods: {
    triggerDeleteAnswer() {
      this.$emit('delete-answer', this.answer)
    },
    toggleLike() {
      this.userLikedAnswer === false ? this.likeAnswer() : this.unlikeAnswer()
    },
    async likeAnswer() {
      this.userLikedAnswer = true
      this.likesCounter += 1
      const endpoint = `/api/v1/answers/${this.answer.uuid}/like/`
      try {
        await axios.post(endpoint);
      } catch(error) {
        console.log(error)
      }
    },
    async unlikeAnswer() {
      this.userLikedAnswer = false
      this.likesCounter -= 1
      const endpoint = `/api/v1/answers/${this.answer.uuid}/like/`
      try {
        await axios.delete(endpoint);
      } catch(error) {
        console.log(error)
      }
    }
  },
}
</script>
