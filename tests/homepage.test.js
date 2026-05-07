import { describe, expect, it, beforeEach } from "vitest";
import { getPageTitle, main } from "../src/homepage.js";

describe("homepage", () => {
    beforeEach(() => {
        document.body.innerHTML = `
            <h1 id="page-title"></h1>
        `;
    });

    it("returns the expected page title", () => {
        expect(getPageTitle()).toBe("DevOps GitHub Actions Lab");
   });

   it("updates the page title element", () => {
        main();

        const heading = document.querySelector("#page-title");

        expect(heading.textContent).toBe("DevOps GitHub Actions Lab");
   });
});