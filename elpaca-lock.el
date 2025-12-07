((cond-let
   :source "elpaca-menu-lock-file" :recipe
   (:package "cond-let" :fetcher github :repo "tarsius/cond-let"
	     :files
	     ("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
	      "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
	      "lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
	      "docs/*.texinfo"
	      (:exclude ".dir-locals.el" "test.el" "tests.el"
			"*-test.el" "*-tests.el" "LICENSE" "README*"
			"*-pkg.el"))
	     :source "elpaca-menu-lock-file" :protocol https :inherit
	     t :depth treeless :ref
	     "8f1661fc9f49cae699948992411d921216ddd4c0"))
 (crux :source "elpaca-menu-lock-file" :recipe
       (:package "crux" :fetcher github :repo "bbatsov/crux" :files
		 ("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
		  "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
		  "lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
		  "docs/*.texinfo"
		  (:exclude ".dir-locals.el" "test.el" "tests.el"
			    "*-test.el" "*-tests.el" "LICENSE"
			    "README*" "*-pkg.el"))
		 :source "elpaca-menu-lock-file" :protocol https
		 :inherit t :depth treeless :ref
		 "3b72275fce66162770b53cf72eb72515c3e68492"))
 (dash :source "elpaca-menu-lock-file" :recipe
       (:package "dash" :fetcher github :repo "magnars/dash.el" :files
		 ("dash.el" "dash.texi") :source
		 "elpaca-menu-lock-file" :protocol https :inherit t
		 :depth treeless :ref
		 "fb443e7a6e660ba849cafcd01021d9aac3ac6764"))
 (dimmer :source "elpaca-menu-lock-file" :recipe
	 (:package "dimmer" :fetcher github :repo
		   "gonewest818/dimmer.el" :files
		   ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		    "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		    "doc/*.texinfo" "lisp/*.el" "docs/dir"
		    "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		    (:exclude ".dir-locals.el" "test.el" "tests.el"
			      "*-test.el" "*-tests.el" "LICENSE"
			      "README*" "*-pkg.el"))
		   :source "elpaca-menu-lock-file" :protocol https
		   :inherit t :depth treeless :ref
		   "a5b697580e5aed6168b571ae3d925753428284f8"))
 (doom-modeline :source "elpaca-menu-lock-file" :recipe
		(:package "doom-modeline" :repo
			  "seagle0128/doom-modeline" :fetcher github
			  :files
			  ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			   "*.texinfo" "doc/dir" "doc/*.info"
			   "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			   "docs/dir" "docs/*.info" "docs/*.texi"
			   "docs/*.texinfo"
			   (:exclude ".dir-locals.el" "test.el"
				     "tests.el" "*-test.el"
				     "*-tests.el" "LICENSE" "README*"
				     "*-pkg.el"))
			  :source "elpaca-menu-lock-file" :protocol
			  https :inherit t :depth treeless :ref
			  "72b475e8dc3bd1a2477d0dcc697306184c00ec5c"))
 (elpaca :source
   "elpaca-menu-lock-file" :recipe
   (:source nil :protocol https :inherit ignore :depth 1 :repo
	    "https://github.com/progfolio/elpaca.git" :ref
	    "b5ef5f19ac1224853234c9acdac0ec9ea1c440a1" :files
	    (:defaults "elpaca-test.el" "extensions/*") :build
	    (:not elpaca--activate-package) :package "elpaca"))
 (emacsql :source "elpaca-menu-lock-file" :recipe
	  (:package "emacsql" :fetcher github :repo "magit/emacsql"
		    :files (:defaults "README.md" "sqlite") :source
		    "elpaca-menu-lock-file" :protocol https :inherit t
		    :depth treeless :ref
		    "f6864fa3510e40e078df924a71d6cdfdfa23283c"))
 (expand-region :source "elpaca-menu-lock-file" :recipe
		(:package "expand-region" :repo
			  "magnars/expand-region.el" :fetcher github
			  :files
			  ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			   "*.texinfo" "doc/dir" "doc/*.info"
			   "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			   "docs/dir" "docs/*.info" "docs/*.texi"
			   "docs/*.texinfo"
			   (:exclude ".dir-locals.el" "test.el"
				     "tests.el" "*-test.el"
				     "*-tests.el" "LICENSE" "README*"
				     "*-pkg.el"))
			  :source "elpaca-menu-lock-file" :protocol
			  https :inherit t :depth treeless :ref
			  "351279272330cae6cecea941b0033a8dd8bcc4e8"))
 (f :source "elpaca-menu-lock-file" :recipe
    (:package "f" :fetcher github :repo "rejeep/f.el" :files
	      ("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
	       "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
	       "lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
	       "docs/*.texinfo"
	       (:exclude ".dir-locals.el" "test.el" "tests.el"
			 "*-test.el" "*-tests.el" "LICENSE" "README*"
			 "*-pkg.el"))
	      :source "elpaca-menu-lock-file" :protocol https :inherit
	      t :depth treeless :ref
	      "931b6d0667fe03e7bf1c6c282d6d8d7006143c52"))
 (general :source "elpaca-menu-lock-file" :recipe
	  (:package "general" :fetcher github :repo
		    "noctuid/general.el" :files
		    ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		     "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		     "doc/*.texinfo" "lisp/*.el" "docs/dir"
		     "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		     (:exclude ".dir-locals.el" "test.el" "tests.el"
			       "*-test.el" "*-tests.el" "LICENSE"
			       "README*" "*-pkg.el"))
		    :source "elpaca-menu-lock-file" :protocol https
		    :inherit t :depth treeless :ref
		    "a48768f85a655fe77b5f45c2880b420da1b1b9c3"))
 (golden-ratio :source "elpaca-menu-lock-file" :recipe
	       (:package "golden-ratio" :repo "roman/golden-ratio.el"
			 :fetcher github :files
			 ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			  "*.texinfo" "doc/dir" "doc/*.info"
			  "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			  "docs/dir" "docs/*.info" "docs/*.texi"
			  "docs/*.texinfo"
			  (:exclude ".dir-locals.el" "test.el"
				    "tests.el" "*-test.el"
				    "*-tests.el" "LICENSE" "README*"
				    "*-pkg.el"))
			 :source "elpaca-menu-lock-file" :protocol
			 https :inherit t :depth treeless :ref
			 "375c9f287dfad68829582c1e0a67d0c18119dab9"))
 (llama :source "elpaca-menu-lock-file" :recipe
	(:package "llama" :fetcher github :repo "tarsius/llama" :files
		  ("llama.el" ".dir-locals.el") :source
		  "elpaca-menu-lock-file" :protocol https :inherit t
		  :depth treeless :ref
		  "472f5967f6684342d3c042d1ba12c3b3d6cefaba"))
 (magit-section :source "elpaca-menu-lock-file" :recipe
		(:package "magit-section" :fetcher github :repo
			  "magit/magit" :files
			  ("lisp/magit-section.el"
			   "docs/magit-section.texi"
			   "magit-section-pkg.el")
			  :source "elpaca-menu-lock-file" :protocol
			  https :inherit t :depth treeless :ref
			  "3fe795e51af33c802dc3f00b91a503955777a002"))
 (marginalia :source "elpaca-menu-lock-file" :recipe
	     (:package "marginalia" :repo "minad/marginalia" :fetcher
		       github :files
		       ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			"*.texinfo" "doc/dir" "doc/*.info"
			"doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			"docs/dir" "docs/*.info" "docs/*.texi"
			"docs/*.texinfo"
			(:exclude ".dir-locals.el" "test.el"
				  "tests.el" "*-test.el" "*-tests.el"
				  "LICENSE" "README*" "*-pkg.el"))
		       :source "elpaca-menu-lock-file" :protocol https
		       :inherit t :depth treeless :ref
		       "d38041df2c2d175040bbdb1df6e4cc75a75ca4f8"))
 (monokai-theme :source "elpaca-menu-lock-file" :recipe
		(:package "monokai-theme" :repo
			  "eliaskanelis/monokai-emacs" :fetcher github
			  :files
			  ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			   "*.texinfo" "doc/dir" "doc/*.info"
			   "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			   "docs/dir" "docs/*.info" "docs/*.texi"
			   "docs/*.texinfo"
			   (:exclude ".dir-locals.el" "test.el"
				     "tests.el" "*-test.el"
				     "*-tests.el" "LICENSE" "README*"
				     "*-pkg.el"))
			  :source "elpaca-menu-lock-file" :protocol
			  https :inherit t :depth treeless :branch
			  "master" :ref
			  "1295604ef359b53f3ecb49dcc67ffcbbc1175e25"))
 (move-text :source "elpaca-menu-lock-file" :recipe
	    (:package "move-text" :fetcher github :repo
		      "emacsfodder/move-text" :files
		      ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		       "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		       "doc/*.texinfo" "lisp/*.el" "docs/dir"
		       "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		       (:exclude ".dir-locals.el" "test.el" "tests.el"
				 "*-test.el" "*-tests.el" "LICENSE"
				 "README*" "*-pkg.el"))
		      :source "elpaca-menu-lock-file" :protocol https
		      :inherit t :depth treeless :ref
		      "2a8ebefeb0b363681e9562847eca3fd66e090d70"))
 (nerd-icons :source "elpaca-menu-lock-file" :recipe
	     (:package "nerd-icons" :repo
		       "rainstormstudio/nerd-icons.el" :fetcher github
		       :files (:defaults "data") :source
		       "elpaca-menu-lock-file" :protocol https
		       :inherit t :depth treeless :ref
		       "772987a28d6408f840331c52c91d04b623a87048"))
 (no-littering :source "elpaca-menu-lock-file" :recipe
	       (:package "no-littering" :fetcher github :repo
			 "emacscollective/no-littering" :files
			 ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			  "*.texinfo" "doc/dir" "doc/*.info"
			  "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			  "docs/dir" "docs/*.info" "docs/*.texi"
			  "docs/*.texinfo"
			  (:exclude ".dir-locals.el" "test.el"
				    "tests.el" "*-test.el"
				    "*-tests.el" "LICENSE" "README*"
				    "*-pkg.el"))
			 :source "elpaca-menu-lock-file" :protocol
			 https :inherit t :depth treeless :ref
			 "446ca2e41f3f757546dbf5777e14f334bbff515c"))
 (olivetti :source "elpaca-menu-lock-file" :recipe
	   (:package "olivetti" :fetcher github :repo "rnkn/olivetti"
		     :files
		     ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		      "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		      "doc/*.texinfo" "lisp/*.el" "docs/dir"
		      "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		      (:exclude ".dir-locals.el" "test.el" "tests.el"
				"*-test.el" "*-tests.el" "LICENSE"
				"README*" "*-pkg.el"))
		     :source "elpaca-menu-lock-file" :protocol https
		     :inherit t :depth treeless :ref
		     "845eb7a95a3ca3325f1120c654d761b91683f598"))
 (orderless :source "elpaca-menu-lock-file" :recipe
	    (:package "orderless" :repo "oantolin/orderless" :fetcher
		      github :files
		      ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		       "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		       "doc/*.texinfo" "lisp/*.el" "docs/dir"
		       "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		       (:exclude ".dir-locals.el" "test.el" "tests.el"
				 "*-test.el" "*-tests.el" "LICENSE"
				 "README*" "*-pkg.el"))
		      :source "elpaca-menu-lock-file" :protocol https
		      :inherit t :depth treeless :ref
		      "26a384894678a1e51e3bf914af3699a61794fb57"))
 (org :source "elpaca-menu-lock-file" :recipe
      (:package "org" :pre-build
		(progn
		  (require 'elpaca-menu-org)
		  (setq elpaca-menu-org-make-manual t)
		  (elpaca-menu-org--build))
		:host github :repo "emacsmirror/org" :autoloads
		"org-loaddefs.el" :depth treeless :build
		(:not elpaca--generate-autoloads-async) :files
		(:defaults ("etc/styles/" "etc/styles/*" "doc/*.texi"))
		:source "elpaca-menu-lock-file" :protocol https
		:inherit t :ref
		"67906ac56b9475a3ef5addaab1e4a3033f3c963b"))
 (org-block-capf :source "elpaca-menu-lock-file" :recipe
		 (:source "elpaca-menu-lock-file" :protocol https
			  :inherit t :depth treeless :host github
			  :repo "xenodium/org-block-capf" :branch
			  "main" :package "org-block-capf" :ref
			  "080cfd2ed630a6739633b07a8ab6b896a1b5ef4a"))
 (org-bullets :source "elpaca-menu-lock-file" :recipe
	      (:package "org-bullets" :fetcher github :repo
			"integral-dw/org-bullets" :files
			("*.el" "*.el.in" "dir" "*.info" "*.texi"
			 "*.texinfo" "doc/dir" "doc/*.info"
			 "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			 "docs/dir" "docs/*.info" "docs/*.texi"
			 "docs/*.texinfo"
			 (:exclude ".dir-locals.el" "test.el"
				   "tests.el" "*-test.el" "*-tests.el"
				   "LICENSE" "README*" "*-pkg.el"))
			:source "elpaca-menu-lock-file" :protocol
			https :inherit t :depth treeless :ref
			"767f55feb58b840a5a04eabfc3fbbf0d257c4792"))
 (org-roam :source "elpaca-menu-lock-file" :recipe
	   (:package "org-roam" :fetcher github :repo
		     "org-roam/org-roam" :files
		     (:defaults "extensions/*") :source
		     "elpaca-menu-lock-file" :protocol https :inherit
		     t :depth treeless :ref
		     "f4ba41cf3d59084e182a5186d432afc9aa3fc423"))
 (org-roam-ui :source "elpaca-menu-lock-file" :recipe
	      (:package "org-roam-ui" :fetcher github :repo
			"org-roam/org-roam-ui" :files
			(:defaults "out") :source
			"elpaca-menu-lock-file" :protocol https
			:inherit t :depth treeless :ref
			"5ac74960231db0bf7783c2ba7a19a60f582e91ab"))
 (s :source "elpaca-menu-lock-file" :recipe
    (:package "s" :fetcher github :repo "magnars/s.el" :files
	      ("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
	       "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
	       "lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
	       "docs/*.texinfo"
	       (:exclude ".dir-locals.el" "test.el" "tests.el"
			 "*-test.el" "*-tests.el" "LICENSE" "README*"
			 "*-pkg.el"))
	      :source "elpaca-menu-lock-file" :protocol https :inherit
	      t :depth treeless :ref
	      "dda84d38fffdaf0c9b12837b504b402af910d01d"))
 (shrink-path :source "elpaca-menu-lock-file" :recipe
	      (:package "shrink-path" :fetcher gitlab :repo
			"bennya/shrink-path.el" :files
			("*.el" "*.el.in" "dir" "*.info" "*.texi"
			 "*.texinfo" "doc/dir" "doc/*.info"
			 "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			 "docs/dir" "docs/*.info" "docs/*.texi"
			 "docs/*.texinfo"
			 (:exclude ".dir-locals.el" "test.el"
				   "tests.el" "*-test.el" "*-tests.el"
				   "LICENSE" "README*" "*-pkg.el"))
			:source "elpaca-menu-lock-file" :protocol
			https :inherit t :depth treeless :ref
			"c14882c8599aec79a6e8ef2d06454254bb3e1e41"))
 (simple-httpd :source "elpaca-menu-lock-file" :recipe
	       (:package "simple-httpd" :repo
			 "skeeto/emacs-web-server" :fetcher github
			 :files
			 ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			  "*.texinfo" "doc/dir" "doc/*.info"
			  "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			  "docs/dir" "docs/*.info" "docs/*.texi"
			  "docs/*.texinfo"
			  (:exclude ".dir-locals.el" "test.el"
				    "tests.el" "*-test.el"
				    "*-tests.el" "LICENSE" "README*"
				    "*-pkg.el"))
			 :source "elpaca-menu-lock-file" :protocol
			 https :inherit t :depth treeless :ref
			 "3982c55e9061475038a3ccd61aecb2de3d407cec"))
 (vertico :source "elpaca-menu-lock-file" :recipe
	  (:package "vertico" :repo "minad/vertico" :files
		    (:defaults "extensions/vertico-*.el") :fetcher
		    github :source "elpaca-menu-lock-file" :protocol
		    https :inherit t :depth treeless :ref
		    "63a43e13805ca3bc06f9492323d66e238c5d0fea"))
 (websocket :source "elpaca-menu-lock-file" :recipe
	    (:package "websocket" :repo "ahyatt/emacs-websocket"
		      :fetcher github :files
		      ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		       "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		       "doc/*.texinfo" "lisp/*.el" "docs/dir"
		       "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		       (:exclude ".dir-locals.el" "test.el" "tests.el"
				 "*-test.el" "*-tests.el" "LICENSE"
				 "README*" "*-pkg.el"))
		      :source "elpaca-menu-lock-file" :protocol https
		      :inherit t :depth treeless :ref
		      "40c208eaab99999d7c1e4bea883648da24c03be3"))
 (which-key :source "elpaca-menu-lock-file" :recipe
	    (:package "which-key" :repo "justbur/emacs-which-key"
		      :fetcher github :files
		      ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		       "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		       "doc/*.texinfo" "lisp/*.el" "docs/dir"
		       "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		       (:exclude ".dir-locals.el" "test.el" "tests.el"
				 "*-test.el" "*-tests.el" "LICENSE"
				 "README*" "*-pkg.el"))
		      :source "elpaca-menu-lock-file" :protocol https
		      :inherit t :depth treeless :ref
		      "38d4308d1143b61e4004b6e7a940686784e51500")))
