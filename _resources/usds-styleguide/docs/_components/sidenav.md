---
layout: styleguide
type: component
title: Side navigation
category: UI components
lead: "Hierarchical, vertical navigation to place at the side of a page. Note: We're currently developing horizontal navigation and headers for the top of a page."
maturity: alpha
---

{% include code/preview.html component="sidenav" %}
{% include code/accordion.html component="sidenav" %}
<div class="usa-accordion-bordered">
  <button class="usa-button-unstyled usa-accordion-button"
      aria-expanded="true" aria-controls="collapsible-0">
    Documentation
  </button>
  <div id="collapsible-0" aria-hidden="false" class="usa-accordion-content">
    <h4 class="usa-heading">Accessibility</h4>
    <ul class="usa-content-list">
      <li>Ensure the side navigational system is keyboard accessible. Users should be able to tab through each link.</li>
    </ul>
    <h4 class="usa-heading">Usability</h4>
    <h5>When to use</h5>
    <ul class="usa-content-list">
      <li>To display a navigational hierarchy with one to three levels.</li>
      <li>To display the “sub-navigation” within a section of the website.</li>
    </ul>
    <h5>When to consider something else</h5>
    <ul class="usa-content-list">
      <li>If the site has fewer than five pages, consider organizing the page without a navigational hierarchy.</li>
      <li>If your page already has a horizontal and vertical navigation bar, consider ways to simplify your navigation system.</li>
      <li>If your content is within a frame or sub-area of a page, consider ways to simplify your navigation system.</li>
    </ul>
    <h5>Guidance</h5>
    <ul class="usa-content-list">
      <li>Indicate where a user is within the navigational hierarchy. Use the “active” state to show users which page they have navigated to.</li>
      <li>Keep the navigation links short. They can be shorter derivatives of page titles themselves.</li>
      <li>If the navigation hierarchy is too long, users may miss items at the bottom. If it’s too deep, users may miss items that require too many clicks. Usability test to find the right balance between breadth and depth.</li>
    </ul>
  </div>
</div>
