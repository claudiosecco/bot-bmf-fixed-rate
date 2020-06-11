# Bot to get historical data of Interbank Deposit (ID) vs Fixed Rate derivative from brazilian BM&F

Bot in ruby with a pretty straight forward usage. It saves in Downloads folder the Excel spreadsheets of reference prices for each date defined in ```dates.rb```. Some past dates are not available in BM&F's site.

It works with firefox and uses selenium-webdriver gem and geckodriver.

At the time I developed it, I was using ruby 2.6.3. It may not crash with other versions.

To install geckodriver in Arch Linux (for instance):

```
$ sudo pacman -S geckodriver
```

To install selenium-webdriver gem
```
$ bundle install
```

Update your desired dates list in ```dates.rb```

You're good to go with:
```
$ ruby bot.rb
```
## License

All source code in this repository is available under the [The Unlicense](LICENSE) License.
