<template>
  <div class="mt-2">
    <router-link :to="{name: 'question-editor', params: {slug: slug}}" class="btn btn-sm btn-warning me-1">
      Edit
    </router-link>
    <button @click="toggleDeleteConfirmationButton" class="btn btn-sm btn-danger mx-1">{{ deleteButtonText }}</button>
    <button v-show="showDeleteConfirmationButton" @click="deleteQuestion" class="btn btn-sm btn-outline-danger">Yes, delete my question</button>
    <hr>
  </div>
</template>


<script>
import { axios } from "@/common/api.service";
export default {
  name: "QuestionActions",
  props: {
    slug: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      showDeleteConfirmationButton: false,
      deleteButtonText: "Delete"
    }
  },
  methods: {
    async deleteQuestion() {
      const endpoint = `/api/v1/questions/${this.slug}/`;
      try {
        await axios.delete(endpoint);
        this.$router.push({name: "home"})
      } catch(error) {
        console.log(error)
      }
    },
    toggleDeleteConfirmationButton() {
      this.showDeleteConfirmationButton = !this.showDeleteConfirmationButton
      this.deleteButtonText = this.showDeleteConfirmationButton ? "Cancel" : "Delete"
    }
  },
};
</script>
