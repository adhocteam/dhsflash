---
type: component
title: Lists
maturity: alpha
parent: typography
order: 05
---

<!-- Lists section begin -->

<p class="usa-font-lead">Lists organize written information for users.</p>

{% include code/preview.html component="lists" classes="preview-lists" %}
{% include code/accordion.html component="lists" %}
<div class="usa-accordion-bordered usa-accordion-docs">
  <button class="usa-button-unstyled usa-accordion-button"
      aria-expanded="true" aria-controls="collapsible-0">
    Documentation
  </button>
  <div id="collapsible-0" class="usa-accordion-content">
  <h4 class="usa-heading">Implementation</h4>
  <p>Lists are styled by default. For unstyled lists, use either the <code>usa-unstyled-list</code> class or unstyled list mixin: <code>@include unstyled-list;</code>. Both are located in <code>assets/_scss/core/<wbr>utilities.scss</code>.</p>
    <h4 class="usa-heading">Usability</h4>
    <h5>When to use</h5>
    <ul class="usa-content-list">
      <li>Use an ordered list when you need to display text in some ranking, hierarchy, or series of steps.</li>
      <li>Use unordered lists to display text in no specific order.</li>
    </ul>
    <h5>When to consider something different</h5>
    <ul class="usa-content-list">
      <li>If you need to communicate long lists of narrative text.</li>
    </ul>
    <h5>Guidelines</h5>
    <ul class="usa-content-list">
      <li>Use sentence case and begin lists with a capital letter.</li>
      <li>Use punctuation appropriate to the text. Do not leave sentences without periods.</li>
    </ul>
  </div>
</div>
