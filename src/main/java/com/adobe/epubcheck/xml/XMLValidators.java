package com.adobe.epubcheck.xml;

public enum XMLValidators
{
  CONTAINER_20_RNG("schema/20/rng/container.rng"),
  CONTAINER_30_RNC("schema/30/ocf-container-30.rnc"),
  DTBOOK_RNG("schema/20/rng/dtbook-2005-2.rng"),
  ENC_20_RNG("schema/20/rng/encryption.rng"),
  ENC_30_RNC("schema/30/ocf-encryption-30.rnc"),
  IDUNIQUE_20_SCH("schema/20/sch/id-unique.sch"),
  MO_30_RNC("schema/30/media-overlay-30.rnc"),
  MO_30_SCH("schema/30/media-overlay-30.sch"),
  NAV_30_RNC("schema/30/epub-nav-30.rnc"),
  NAV_30_SCH("schema/30/epub-nav-30.sch"),
  NCX_RNG("schema/20/rng/ncx.rng"),
  NCX_SCH("schema/20/sch/ncx.sch"),
  OPF_20_RNG("schema/20/rng/opf.rng"),
  OPF_20_SCH("schema/20/sch/opf.sch"),
  OPF_30_RNC("schema/30/package-30.rnc"),
  OPF_30_SCH("schema/30/package-30.sch"),
  SIG_20_RNG("schema/20/rng/signatures.rng"),
  SIG_30_RNC("schema/30/ocf-signatures-30.rnc"),
  SVG_20_RNG("schema/20/rng/svg11.rng"),
  SVG_30_RNC("schema/30/epub-svg-30.rnc"),
  SVG_30_SCH("schema/30/epub-svg-30.sch"),
  XHTML_20_NVDL("schema/20/rng/ops20.nvdl"),
  XHTML_30_SCH("schema/30/epub-xhtml-30.sch"),
  XHTML_30_RNC("schema/30/epub-xhtml-30.rnc"),
  XHTML_EDUPUB_HEADINGS_SCH("schema/30/edupub/edu-headings.sch"),
  XHTML_EDUPUB_SEMANTICS_SCH("schema/30/edupub/edu-semantics.sch");

  private final XMLValidator val;

  private XMLValidators(String schemaName)
  {
    val = new XMLValidator(schemaName);
  }

  public XMLValidator get()
  {
    return val;
  }

}
