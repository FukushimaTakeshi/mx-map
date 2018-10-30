<template>
  <span>
    <article v-for="item in this.favoriteCourses" :key="item.id" class="media">
      <div class="media-left">
        <figure class="image is-96x96">
          <img :src="item.photo_url || 'http://placehold.it/100/?text=no-image'" alt="Image">
        </figure>
      </div>
      <div class="media-content">
        <div class="content">
          <p>
            <strong>{{ item.name }}</strong>
            <br>
            </p>
        </div>
        <nav class="level is-mobile">
          <div class="level-left">
            <a class="level-item" aria-label="reply">
              <span class="icon is-small">
                <i class="fas fa-reply" aria-hidden="true"></i>
              </span>
            </a>
          </div>
        </nav>
      </div>
    </article>
  </span>
</template>

<script>
import axios from 'axios'

export default {
  props: ['userId'],
  data() {
    return {
      favoriteCourses: []
    }
  },
  mounted: async function() {
    const res = await axios.get(`/api/users/${this.userId}/favorite_courses`)
    if (res.status !== 200) {
      process.exit()
    }
    this.favoriteCourses = res.data.favorite_courses
  }
}
</script>

<style lang="scss">
</style>
