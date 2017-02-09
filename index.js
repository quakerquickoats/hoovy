const {app, BrowserWindow, Main} = require('electron')

let win

function createWindow() {
  console.log('loading ' + __dirname + ' ...')
  win = new BrowserWindow({width: 640, height: 480})
  win.loadURL('file://' + __dirname + '/index.html')
  //win.webContents.openDevTools()
  win.on('closed', () => {win = null})}

app.on('ready', createWindow)
//app.on('ready', startServer)

app.on('window-all-closed', () => {
  console.log('alll quiteee.')
  if (process.platform !== 'darwin')
    app.quit()
})

app.on('activate', () => {
  if (win === null)
    createWindow()
})
