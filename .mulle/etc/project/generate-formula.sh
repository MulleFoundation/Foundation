#
# Generate your `def install` `test do` lines here. echo them to stdout.
#
generate_brew_formula_build()
{
   local project="$1"
   local name="$2"
   local version="$3"

   cat <<EOF

  def install
    system "mulle-sde", "clean", "cache"
    system "mulle-sde","install","--standalone","--prefix","#{prefix}","https://github.com/MulleFoundation/Foundation/archive/refs/tags/latest.tar.gz"
  end
EOF
}
