% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_fusion.R
\name{plot_fusion}
\alias{plot_fusion}
\alias{plot_fusion_separate}
\alias{plot_fusion_together}
\title{Plot a fusion event with transcripts, coverage and ideograms.}
\usage{
plot_fusion(fusion, edb = NULL, bamfile = NULL,
  which_transcripts = "exonBoundary", ylim = c(0, 1000),
  non_ucsc = TRUE, reduce_transcripts = FALSE, bedgraphfile = NULL)

plot_fusion_separate(fusion, edb, bamfile = NULL,
  which_transcripts = "exonBoundary", ylim = c(0, 1000),
  non_ucsc = TRUE, reduce_transcripts = FALSE, bedgraphfile = NULL)

plot_fusion_together(fusion, edb, bamfile = NULL,
  which_transcripts = "exonBoundary", ylim = c(0, 1000),
  non_ucsc = TRUE, reduce_transcripts = FALSE, bedgraphfile = NULL)
}
\arguments{
\item{fusion}{The Fusion object to plot.}

\item{edb}{The ensembldb object that will be used to fetch data.}

\item{bamfile}{The bamfile with RNA-seq data.}

\item{which_transcripts}{This character vector decides which transcripts are
to be plotted. Can be "exonBoundary", "withinExon", "withinIntron",
"intergenic", or a character vector with specific transcript ids. Default
value is "exonBoundary".}

\item{ylim}{Limits for the coverage y-axis.}

\item{non_ucsc}{Boolean indicating whether or not the bamfile used has UCSC-
styled chromosome names (i.e. with the "chr" prefix). Setting this to true
lets you use a bamfile with chromosome names like "1" and "X", instead of
"chr1" and "chrX".}

\item{reduce_transcripts}{Boolean indicating whether or not to reduce all
transcripts into a single transcript for each partner gene.}

\item{bedgraphfile}{A bedGraph file to use instead of the bamfile to plot
coverage.}
}
\value{
Creates a fusion plot.
}
\description{
This function creates a plot with information about transcripts, coverage,
location and more.
}
\details{
plot_fusion() will dispatch to either plot_fusion_separate() or
plot_fusion_together(). plot_fusion_separate() will plot the fusion gene
partners in separate graphs shown next to each other, while
plot_fusion_together() will plot the fusion gene partners in the same graph
with the same x-axis. plot_fusion() will dispatch to plot_fusion_together() if
the fusion gene partners are on the same strand, same chromosome and are
close together (<=50,000 bp apart).
}
\examples{
# Load data and example fusion event
defuse833ke <- system.file(
  "extdata",
  "defuse_833ke_results.filtered.tsv",
  package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
edbSqliteFile <- system.file(
  "extdata",
  "Homo_sapiens.GRCh37.74.sqlite",
  package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# bamfile with reads in the regions of this fusion event
bamfile5267 <- system.file(
  "extdata",
  "fusion5267and11759reads.bam",
  package="chimeraviz")
# Temporary file to store the plot
pngFilename <- tempfile(
  pattern = "fusionPlot",
  fileext = ".png",
  tmpdir = tempdir())
# Open device
png(pngFilename, width = 1000, height = 750)
# Plot!
plot_fusion(
  fusion = fusion,
  bamfile = bamfile5267,
  edb = edb,
  non_ucsc = TRUE)
# Close device
dev.off()

# Example using a .bedGraph file instead of a .bam file:
# Load data and example fusion event
defuse833ke <- system.file(
  "extdata",
  "defuse_833ke_results.filtered.tsv",
  package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
edbSqliteFile <- system.file(
  "extdata",
  "Homo_sapiens.GRCh37.74.sqlite",
  package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# bedgraphfile with coverage data from the regions of this fusion event
bedgraphfile <- system.file(
  "extdata",
  "fusion5267and11759reads.bedGraph",
  package="chimeraviz")
# Temporary file to store the plot
pngFilename <- tempfile(
  pattern = "fusionPlot",
  fileext = ".png",
  tmpdir = tempdir())
# Open device
png(pngFilename, width = 1000, height = 750)
# Plot!
plot_fusion(
  fusion = fusion,
  bedgraphfile = bedgraphfile,
  edb = edb,
  non_ucsc = TRUE)
# Close device
dev.off()

}
