# bot to extract data or brazilian interest rates from BM&F
# works with firefox
# intall geckodriver in your system
# in arch: sudo pacman -S geckodriver

# needs to install it via 'bundle install'
require 'selenium-webdriver'

# clicks the button to export in Excel format
def click(driver, date)
  begin
    driver.find_element(:css, 'img').click
    a = driver.switch_to.alert
    a.accept
  rescue => ex 
    return true
  end
  puts "#{date} - missing"
end

profile = Selenium::WebDriver::Firefox::Profile.new

# specify a download directory
profile['browser.download.dir'] = "~/Downloads/bmf"
profile['browser.download.folderList'] = 2

# notes about mime types:
# set the preference via GUI
# find profile_directory in menu Help/'Troubleshooting information'
# mime types are in profile_directory/handlers.json
profile['browser.helperApps.neverAsk.saveToDisk'] = "application/vnd.ms-excel"

# in my source, line bellow was needed in case of pdf mime type
#profile['pdfjs.disabled'] = true

options = Selenium::WebDriver::Firefox::Options.new(profile: profile)
capabilities = 
  Selenium::WebDriver::Remote::Capabilities.firefox(
    accept_insecure_certs: true)
driver = Selenium::WebDriver.for :firefox, 
  options: options,
  desired_capabilities: capabilities

require './dates.rb'
dates = get_dates()

dates.each do |date|

  url =   "https://www2.bmf.com.br/pages/portal/bmfbovespa/boletim1/TxRef1.asp"
  url +=  "?Data=#{date}"

  driver.get(url)

  click(driver, date)

end

