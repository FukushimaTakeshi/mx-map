<template>
  <div class="carousel">
    <transition-group name="slide" tag="div" class="carousel__slider">
      <div v-for="number in [currentImg]" v-bind:key="number">
        <img :src="imgList[Math.abs(currentImg) % imgList.length] || 'http://placehold.it/150/?text=no-image'" class="carousel__img"/>
      </div>
    </transition-group>
  </div>
</template>

<script>
  export default {
    props:{
      imgList: Array
    },
    data: function() {
      return {
        currentImg: 0,
      }
    },
    mounted: function() {
      this.onTimer()
    },
    methods:{
      next: function() {
        this.currentImg++
      },
      onTimer: function () {
        setInterval(() => {
          this.next()
        }, 5000)
      }
    }
  }
</script>

<style lang="scss">
.slide-enter-active, .slide-leave-active {
  transition: opacity .9s;
}
.slide-enter {
  opacity: 0;
}
.slide-leave-active {
  opacity: 0;
}


.carousel{
  &__img {
    max-width: 100%;
    max-height: 100%;
    width: auto;
    height: auto;
  }

  &__slider{
    position: relative;
    width: 143px;
    height: 115px;
    border: 1px solid lightgray;
    img {
      position: absolute;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      margin: auto;
    }
  }
}
</style>
