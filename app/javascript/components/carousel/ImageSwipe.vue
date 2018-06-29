<template>
  <div class="image-swipe">
    <div class="image-swipe__body" v-bind:style="{width: itemWidth + 'px'}">
      <v-touch @swipeleft="onSwipeLeft" @swiperight="onSwipeRight" :swipe-options="{direction: 'horizontal'}">
        <transition-group name="image-swipe__list" tag="div" class="image-swipe__container">
          <figure v-for="index in [currentIndex]" v-bind:key="index" v-bind:style="{width: itemWidth + 'px'}" class="image-carousel__item">
            <img :src="images[Math.abs(currentIndex) % images.length]" class="image-carousel__item__image">
          </figure>
        </transition-group>
      </v-touch>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      images: Array,
      itemWidth: 0
    },
    data: function() {
      return {
        currentIndex: 0,
      }
    },
    methods: {
      onSwipeLeft: function() {
        this.displayNext()
      },

      onSwipeRight: function() {
        this.displayPrevious()
      },
      wholeWidth: function() {
        return this.itemWidth * this.images.length
      },
      margin: function() {
        return this.currentIndex * -1 * this.itemWidth
      },
      imageRange: function() {
        return Array.from({length: this.images.length}, (k, v) => v);
      },
      displayPrevious: function() {
        if(this.currentIndex > 0) {
          this.currentIndex--
        }
      },
       displayNext: function() {
        if(this.currentIndex < this.images.length - 1) {
          this.currentIndex++
        }
      }
    }
  }
</script>

<style lang="scss">
.image-carousel {
    &__body {
        overflow: hidden;
        margin: 0px auto;
    }
    &__container {
        height: 580px;
        transition: all 500ms linear 0s;
    }
    &__item {
        margin: 0px 0px;
        display: inline-block;
    }
}
</style>
