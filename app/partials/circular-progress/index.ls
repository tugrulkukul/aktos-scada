require! {
  '../../modules/aktos-dcs': {
    RactivePartial,
    IoActor,
    
  }
}


/* usage example 

  {{>circular-progress {pin_name: ..., color: 'blue green'} }}
  
  color: '#2345 #88776'
  color: 'red'

*/

RactivePartial! .register ->
  $ \.circular-progress .each ->
    
    actor = IoActor $ this
    elem = actor.node
    color = actor.get-ractive-var \color

    params =
      value: 0.35
      size: 100
      animation: false
      thickness: 10
        
    if not color or color is ''
      color = '#ff1e41 #ff5f43'
    
    colors = color.split ' '
    
    params = $.extend params, do
      fill: gradient: colors
  
    
    elem.circle-progress params
    
    actor.add-callback (msg) ->
      elem.circle-progress \value, (msg.val / 100)
      actor.set-ractive-var \val, msg.val

/*  
  $ \.circle1 .circle-progress do       
    value: 0.35
    size: 80
    animation: false
    fill: do
      gradient: ['#ff1e41', '#ff5f43']
  
  $ \.circle2 .circle-progress do
    value: 0.6
  .on 'circle-animation-progress', (event, progress) ->
    $ this .find \strong .html parse-int(100 * progress) + '<i>%</i>'
  
  
  $ \.circle3 .circle-progress do
    value: 0.75
    fill: do
      gradient: [['#0681c4', 0.5], ['#4ac5f8', 0.5]]
      gradientAngle: Math.PI / 4
  .on 'circle-animation-progress', (event, progress, step-value) ->
    $ this .find \strong .text String(step-value.toFixed(2)).substr 1  
  */
