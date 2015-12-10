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


loadNextPage = ->
  if currPage + 1 < totalPage
    currPage += 1
    renderPage(currPage)


loadLastPage = ->
  if currPage - 1 > -1
    currPage -= 1
    renderPage(currPage)


renderPage = (index) ->
  up = (index + 1) * config.limit
  low = up - config.limit
  content = templates['page-list'](page: posts.slice(low, up))
  postList.innerHTML = content


currPage = 0
totalPage = null
posts = null
postList = null

document.addEventListener 'DOMContentLoaded', ->
  currActive = document.querySelector('.nav-item.active')
  currSection = document.querySelector('main')
  postList = document.querySelector('.post-list')

  if currSection.dataset.toggle == 'blog'
    btnLast = document.querySelector('.last')
    btnLast.addEventListener 'click', loadLastPage

    btnNext = document.querySelector('.next')
    btnNext.addEventListener 'click', loadNextPage

    loadJSON()
      .then (content) ->
        posts = JSON.parse(content).posts.items
        totalPage = Math.ceil(posts.length / config.limit)

      .catch (err) ->
        console.warn err

  if currSection.dataset.toggle && currSection.dataset.toggle != currActive.dataset.toggle
    query = ".nav-item[data-toggle=#{currSection.dataset.toggle}]"
    currSection = document.querySelector(query)
    currActive.classList.remove('active')
    currSection.classList.add('active')

  navMenu = document.querySelector('.author')
  navMenu.addEventListener 'click', toggleNavMenu
