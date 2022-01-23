# pip install python-telegram-bot
import telegram
import pyautogui
from telegram.ext import Updater
from telegram.ext import CommandHandler

telegram_token = ''
telegram_chat_id = ?
 
bot = telegram.Bot(token = telegram_token)
updater = Updater(token = telegram_token)
 
def send_message(update, context):
    pyautogui.screenshot('mapsc.png', region=(174,108,660,529))
    bot.send_photo(chat_id = telegram_chat_id, photo= open('mapsc.png','rb'))
    
def add_handler(cmd, func):
    updater.dispatcher.add_handler(CommandHandler(cmd, func))
 
add_handler('map', send_message)
 
updater.start_polling()
updater.idle()