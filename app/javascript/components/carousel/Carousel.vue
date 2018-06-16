<template>
  <div class="carousel">
    <transition-group name="slide" tag="div" class="carousel__slider">
      <div v-for="number in [currentImg]" v-bind:key="number">
        <img :src="imgList[Math.abs(currentImg) % imgList.length]" class="carousel__img"/>
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
        }, 3000)
      }
    }
  }
</script>

<style lang="scss">
.slide-enter-active, .slide-leave-active {
  transition: transform .1s
}
.slide-enter {
  transform: translateX(300px)
}
.slide-leave-active {
  transform: translateX(-300px);
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
    width: 130px;
    height: 120px;
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
