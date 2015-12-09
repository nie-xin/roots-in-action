toggleNavMenu = (e) ->
  menu = document.querySelector('.nav-menu')
  classList = menu.classList

  if 'off' in classList
    classList.remove('off')
  else
    classList.add('off')


document.addEventListener 'DOMContentLoaded', ->
  currActive = document.querySelector('.nav-item.active')
  currSection = document.querySelector('main')

  if currActive.dataset.toggle != currSection.dataset.toggle
    query = ".nav-item[data-toggle=#{currSection.dataset.toggle}]"
    currSection = document.querySelector(query)
    currActive.classList.remove('active')
    currSection.classList.add('active')

  navMenu = document.querySelector('.author')
  navMenu.addEventListener 'click', toggleNavMenu
