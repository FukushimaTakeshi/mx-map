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
      this.onTimer();
    },
    methods:{
      next: function() {
        this.currentImg++
      },
      onTimer: function () {
        setInterval(() => {
          this.next();
        }, 2000)
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
  // width:100%;

  &__slider{
    overflow: hidden;
    position: relative;
    margin:0 auto;
      background:white;
  }

  &__img{
    position:absolute;
    top:0;
    bottom:0;
    left:0;
    height:128px;
    width:128px;
  }
}
</style>
