Feature: EPUB 3 Content
  
  Checks conformance to specification rules related to EPUB Content Documents:
  https://www.w3.org/publishing/epub32/epub-contentdocs.html
  
  This feature file contains tests for EPUBCheck running in default mode to check
  full EPUB publications.
  
  Note: Tests that do not require a full publication but a single Content
        Document are defined in the `content-document-xhtml.feature` and
        `content-document-svg.feature` feature files.

  Background: 
    Given EPUB test files located at '/epub3/files/epub/'
    And EPUBCheck with default settings



  #  2. XHTML Content Documents

  Scenario: Verify a minimal EPUB
    When checking EPUB 'minimal'
    Then no errors or warnings are reported


  ##  2.2 Content Conformance
  
  ###  Document Properties - HTML Conformance

  ####  base

  Scenario: Verify that a base url can be set
    When checking EPUB 'base-url-valid'
    Then no errors or warnings are reported

  Scenario: Report relative paths as remote resources when HTML `base` is set to an extenal URL (issue 155)
    When checking EPUB 'base-url-remote-relative-path-error'
    Then error RSC-006 is reported
    And no other errors or warnings are reported

  Scenario: Report relative paths as remote resources when `xml:base` is set to an extenal URL (issue 155)
    When checking EPUB 'xml-base-url-remote-relative-path-error'
    Then error RSC-006 is reported
    And no other errors or warnings are reported


  ####  data attributes

  Scenario: Report invalid elements after a `data-*` attribute (issue 189 - was allowed by stripping of `data-*` attributes)
    When checking EPUB 'data-attr-removal-markup-error'
    Then error RSC-005 is reported
    And the message contains 'element "somebadxhtmlformatting" not allowed here'
    And no other errors or warnings are reported

  Scenario: Verify fragment identifiers are allowed in attributes after a `data-*` declaration (issue 198 - caused error from stripping of `data-*` attributes)
    When checking EPUB 'data-attr-removal-fragments-valid'
    Then no errors or warnings are reported


  ####  hyperlinks

  Scenario: Report a hyperlink to a resource missing from the publication
    When checking EPUB 'html-link-to-missing-doc-error'
    Then error RSC-007 is reported
    And no errors or warnings are reported

  Scenario: Report a hyperlink to a missing identifier
    When checking EPUB 'html-link-to-missing-id-error'
    Then error RSC-012 is reported
    And no errors or warnings are reported

  Scenario: Report a hyperlink to a mising identifier in another document
    When checking EPUB 'html-link-to-missing-id-xref-error'
    Then error RSC-012 is reported
    And no errors or warnings are reported

  Scenario: Verify that href values that only contain whitepace are allowed (issue 225 asked for a warning, but an empty string is a valid URL)
    When checking EPUB 'html-link-href-empty-valid'
    Then no errors or warnings are reported

  Scenario: Verify `object` element does not cause issues with fragment references (issue 226)
    When checking EPUB 'html-link-fragment-after-object-valid'
    Then no errors or warnings are reported

  Scenario: Verify that relative paths starting with a single dot are resolved properly (issue 270)
    When checking EPUB 'html-link-rel-path-dot-valid'
    Then no errors or warnings are reported

  Scenario: Report a link to a resource that is not in the spine
    When checking EPUB 'html-link-out-of-spine-error'
    Then error RSC-011 is reported
    And no other errors or warnings are reported

  Scenario: Report a reference from an XHTML doc to a resource not declared in the manifest
    When checking EPUB 'resource-xhtml-ref-missing-error'
    Then error RSC-007 is reported
    And no other errors or warnings are reported


  ####  iframes
  
  Scenario: Verify that an `iframe` can reference another XHTML document
    When checking EPUB 'iframe-basic-valid'
    Then no errors or warnings are reported


  ####  img

  Scenario: Verify that an `img` element can reference a foreign resource so long as it has a manifest fallback (and is not in a `picture` element)
    When checking EPUB 'img-manifest-fallback-valid'
    Then no errors or warnings are reported

  Scenario: Verify that an `img srcset` can reference foreign resources when they have manifest fallbacks
    When checking EPUB 'img-srcset-manifest-fallback-valid'
    Then no errors or warnings are reported

  Scenario: Report an `img src` with a foreign resource and no manifest fallback (when the `img` is not in a `picture` element)
    When checking EPUB 'img-src-no-manifest-fallback-error'
    Then error MED-003 is reported
    And no other errors or warnings are reported

  Scenario: Verify that `img` element can reference SVG fragments
    When checking EPUB 'img-fragment-svg-valid'
    Then no errors or warnings are reported

  Scenario: Report non-SVG images referenced as fragments
    When checking EPUB 'img-fragment-non-svg-warning'
    # 1 warning for an HTML `img` element - 1 warning for an SVG `image` element
    Then warning RSC-009 is reported 2 times
    And no other errors or warnings are reported

  Scenario: Report references to undeclared resources in `img srcset`
    When checking EPUB 'img-srcset-undeclared-error'
    # undeclared resource in srcset
    Then error RSC-008 is reported
    # undeclared resource in container
    And warning OPF-003 is reported
    And no other errors or warnings are reported


  ####  meta

  Scenario: Verify that `viewport meta` declaration is not checked for non-fixed layout documents (issue 419)
    When checking EPUB 'meta-viewport-non-fxl-valid'
    Then no errors or warnings are reported


  ####  object

  Scenario: Report an `object` element without a fallback
    When checking EPUB 'object-no-fallback-error'
    Then error MED-002 is reported
    And no other errors or warnings are reported


  ####  SVG

  Scenario: Verify that an SVG image can be referenced from `img`, `object` and `iframe` elements
    When checking EPUB 'svg-reference-valid'
    Then no errors or warnings are reported

  Scenario: Verify that `svg:switch` doesn't trigger the package document `switch` property check
    When checking EPUB 'svg-switch-valid'
    Then no errors or warnings are reported

  Scenario: Verify that `svgView` fragments are allowed when associated to SVG documents
    When checking EPUB 'svg-fragment-svgview-valid'
    Then no errors or warnings are reported


  ####  video
  
  Scenario: Report a `poster` attribute that references an invalid media type 
    When checking EPUB 'video-poster-media-type-error'
    Then error MED-001 is reported
    And no other errors or warnings are reported


  ####  xpgt

  Scenario: Verify an xpgt style sheet with a manifest fallback to css
    When checking EPUB 'xpgt-manifest-fallback-valid'
    Then no errors or warnings are reported

  Scenario: Verify an xpgt style sheet with an implicit fallback to css in an xhtml document
    When checking EPUB 'xpgt-implicit-fallback-valid'
    Then no errors or warnings are reported

  Scenario: Report an xpgt style sheet without a fallback
    When checking EPUB 'xpgt-no-fallback-error'
    Then error CSS-010 is reported
    And no other errors or warnings are reported


  ### File Properties
  
  Scenario: Report an XHTML content document without an `.xhtml` extension
    When checking EPUB 'xhtml-extension-warning'
    Then warning HTM-014a is reported
    And no other errors or warnings are reported


  ###  2.5.5 Foreign Resource Restrictions

  ####  picture

  Scenario: Report a `picture` element with a foreign resource in its `img src` fallback  
    When checking EPUB 'picture-fallback-img-foreign-src-error'
    Then error MED-007 is reported
    And no other errors or warnings are reported

  Scenario: Report a `picture` element with a foreign resource in its `img srcset` fallback
    When checking EPUB 'picture-fallback-img-foreign-srcset-error'
    Then error MED-007 is reported 2 times
    And no other errors or warnings are reported

  Scenario: Verify the `picture source` element can reference foreign resources so long as the `type` attribute is declared
    When checking EPUB 'picture-source-foreign-with-type-valid'
    Then no errors or warnings are reported

  Scenario: Report a `picture source` element that does not include a `type` attribute for a foreign resource
    When checking EPUB 'picture-source-foreign-no-type-error'
    Then error MED-007 is reported
    And no other errors or warnings are reported

  Scenario: Report a `picture source` element that references a foreign resource but incorrectly states a core media type in its `type` attribute
    When checking EPUB 'picture-source-foreign-with-cmt-type-error'
    Then error MED-007 is reported
    And no other errors or warnings are reported


  #### link

  Scenario: Verify test that a foreign resource used in an HTML `link` can be included without fallback
    # this test does not match the specification (see issue 1312)
    When checking EPUB 'foreign-res-in-html-link-valid'
    Then no errors or warnings are reported


  #  3. SVG Content Documents

  Scenario: Verify that the need for a `viewbox` declaration does not apply to non-fixed layout SVGs
    When checking EPUB 'svg-no-viewbox-not-fxl-valid'
    Then no errors or warnings are reported


  #  6.  Fixed Layouts

  ##  6.2 Content Conformance

  Scenario: Verify a fixed-layout SVG
    When checking EPUB 'fxl-svg-valid'
    Then no errors or warnings are reported


  ##  6.5 Initial Containing Block Dimensions

  ###  6.5.2 Expressing in SVG

  Scenario: Verify that the initial containing block rules are not checked on embedded svg elements
    When checking EPUB 'fxl-svg-no-viewbox-on-inner-svg-valid'
    Then no errors or warnings are reported

  Scenario: Report a fixed-layout SVG without a `viewbox` declaration
    When checking EPUB 'fxl-svg-no-viewbox-error'
    Then error HTM-048 is reported
    And no other errors or warnings are reported

  Scenario: Report a fixed-layout SVG without a `viewbox` declaration (only `width`/`height` in units)
    When checking EPUB 'fxl-svg-no-viewbox-width-height-units-error'
    Then error HTM-048 is reported
    And no other errors or warnings are reported

  Scenario: Report a fixed-layout SVG without a `viewbox` declaration (only `width`/`height` in percent)
    When checking EPUB 'fxl-svg-no-viewbox-width-height-percent-error'
    Then error HTM-048 is reported
    And no other errors or warnings are reported


  #  4. CSS Style Sheets

  Scenario: Report an attempt to `@import` a CSS file that declared in the package document but not present in the container
    When checking EPUB 'css-import-not-present-error'
    Then error RSC-001 is reported
    And no other errors or warnings are reported

  Scenario: Report an attempt to `@import` a CSS file that is not declared in the manifest but is present in the container
    When checking EPUB 'css-import-not-declared-error'
    Then error RSC-008 is reported
    And warning OPF-003 is reported
    And no other errors or warnings are reported

  Scenario: Report a CSS `url` that is not declared in the package document or present in the container
    When checking EPUB 'css-url-not-present-error'
    Then error RSC-007 is reported
    And no other errors or warnings are reported

  Scenario: Report a CSS `font-size` value without a unit specified
    When checking EPUB 'css-font-size-no-unit-error'
    Then error CSS-020 is reported 3 times
    And no other errors or warnings are reported

  Scenario: Report a CSS file with a `@charset` declaration that is not utf-8
    When checking EPUB 'css-charset-enc-error'
    Then error CSS-003 is reported
    And no other errors or warnings are reported

  Scenario: Verify that CSS `font-size: 0` declaration is allowed (issue 922)
    When checking EPUB 'css-font-size-zero-valid'
    Then no errors or warnings are reported

  Scenario: Report an invalid CSS `font-size` value
    When checking EPUB 'css-font-size-value-error'
    Then error CSS-020 is reported 2 times
    And no other errors or warnings are reported

  Scenario: Verify that namespace URIs in CSS are not recognized as remote resources (issue 237) 
    When checking EPUB 'css-namespace-uri-not-resource-valid'
    Then no errors or warnings are reported
