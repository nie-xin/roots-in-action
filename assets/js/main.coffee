document.addEventListener 'DOMContentLoaded', =>
  currActive = document.querySelector('.nav-tab.active')
  currSection = document.querySelector('main')

  if currActive.dataset.toggle != currSection.dataset.toggle
    currTab = document.querySelector(".nav-tab[data-toggle=#{currSection.dataset.toggle}")
    currActive.classList.remove('active')
    currTab.classList.add('active')
