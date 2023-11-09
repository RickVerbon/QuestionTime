<template>
  <div class="mt-2">
    <router-link :to="{name: 'question-editor', params: {slug: slug}}" class="btn btn-sm btn-warning me-1">
      Edit
    </router-link>
    <button @click="showDeleteConfirmationButton = !showDeleteConfirmationButton" class="btn btn-sm btn-danger mx-1">Delete</button>
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
      showDeleteConfirmationButton: false
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
    }
  },
};
</script>
