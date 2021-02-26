const { link } = require("fs");
const puppeteer = require("puppeteer");

(async () => {
    const usersLocation = "https://nscstrdevusw2thucommon.z5.web.core.windows.net/users";
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto(usersLocation)
    console.log(await page.title());

    await browser.close();
})();