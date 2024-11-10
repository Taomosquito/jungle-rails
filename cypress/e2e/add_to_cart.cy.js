it("when clicking on Add button for product adds it to the cart", () => {
  cy.visit("/");
  cy.get(".btn").first().should("be.visible").click({ force: true });
  cy.contains(" My Cart (1) ").should("be.visible");
  cy.get(".btn").last().should("be.visible").click({ force: true });
  cy.contains(" My Cart (2) ").should("be.visible");
});
