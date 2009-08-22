from SeleniumLibrary import SeleniumLibrary


class WebLibrary(SeleniumLibrary):

    def open_login_page(self):
        self.open_browser('http://localhost:4567/')
        self.set_selenium_speed(0)

    def exit(self):
        self.close_browser()

    def create_user(self, username, password):
        self.go_to('http://localhost:4567/')
        self.click_link('create', dont_wait=True)
        self.input_text('uname', username)
        self.input_text('pwd', password)
        self.click_button('Create Account')
        return self.get_text('message')

    def attempt_to_login(self, username, password):
        self.go_to('http://localhost:4567/')
        self.click_link('login', dont_wait=True)
        self.input_text('uname', username)
        self.input_text('pwd', password)
        self.click_button('Login')
        return self.get_text('message')
