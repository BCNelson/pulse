package main

import (
	"net/http"
	"os"
	"path"
	"path/filepath"
)

// staticSPAHandler serves files from dir, falling back to index.html for
// any path that doesn't resolve to a regular file. That's the SPA-routing
// contract — Flutter's hash-less / path-based routes need the server to
// hand back index.html so the client router can take over.
func staticSPAHandler(dir string) http.HandlerFunc {
	indexPath := filepath.Join(dir, "index.html")
	fs := http.FileServer(http.Dir(dir))
	return func(w http.ResponseWriter, r *http.Request) {
		clean := path.Clean("/" + r.URL.Path)
		full := filepath.Join(dir, clean)
		if info, err := os.Stat(full); err == nil && !info.IsDir() {
			fs.ServeHTTP(w, r)
			return
		}
		http.ServeFile(w, r, indexPath)
	}
}
