---
title: Name form
parent: Form templates
maturity: alpha
order: 01
lead: A standard template for collecting a person’s full name
---

{% include code/preview.html component="name-form" %}
{% include code/accordion.html component="name-form" %}
<div class="usa-accordion-bordered usa-accordion-docs">
  <button class="usa-button-unstyled usa-accordion-button"
      aria-expanded="true" aria-controls="collapsible-0">
    Documentation
  </button>
  <div id="collapsible-0" aria-hidden="false" class="usa-accordion-content">
    <h4 class="usa-heading">Accessibility</h4>
    <ul class="usa-content-list">
      <li>As you customize this form template, ensure it continues to follow the <a href="{{ site.baseurl }}/form-templates/">accessibility guidelines for form templates</a> and the <a href="{{ site.baseurl }}/form-controls/">accessibility guidelines for form controls</a>.</li>
    </ul>
    <h4 class="usa-heading">Usability</h4>
    <h5>When to use</h5>
    <ul class="usa-content-list">
      <li>When you need to collect users’ full names and store the parts separately in a database.</li>
    </ul>
    <h5>When to consider something else</h5>
    <ul class="usa-content-list">
      <li>If you don’t need to parse out the separate pieces of a person’s name, consider letting them enter it into a single text field.</li>
    </ul>
    <h5>Guidance</h5>
    <ul class="usa-content-list">
      <li>Leave the title and suffix fields as text boxes instead of offering drop downs. There are many possible titles and suffixes; text boxes accommodate them all.</li>
      <li>Do not restrict the types of characters users can enter in any of these fields. Names can include characters outside the standard Roman alphabet.</li>
    </ul>
  </div>
</div>
