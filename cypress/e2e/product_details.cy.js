it("can navigate to the product detail page by clicking on product partial", () => {
  cy.visit("/");
  cy.get('[alt="Scented Blade"]').click();
  cy.get("h1").contains("Scented Blade");
});
