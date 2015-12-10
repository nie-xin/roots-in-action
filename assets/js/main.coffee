loadJSON =  ->
  new Promise (resolve, reject) ->
    xhr = new XMLHttpRequest()
    xhr.overrideMimeType('application/json')
    xhr.open('GET', 'content.json', true)

    xhr.onload = ->
      if xhr.status == 200
        resolve(xhr.responseText)
      else
        reject(xhr.statusText)

    xhr.send(null)


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

  if currSection.dataset.toggle == 'blog'
    loadJSON()
      .then (content) ->
        console.log content
      .catch (err) ->
        console.log err


  if currSection.dataset.toggle && currSection.dataset.toggle != currActive.dataset.toggle
    query = ".nav-item[data-toggle=#{currSection.dataset.toggle}]"
    currSection = document.querySelector(query)
    currActive.classList.remove('active')
    currSection.classList.add('active')

  navMenu = document.querySelector('.author')
  navMenu.addEventListener 'click', toggleNavMenu
