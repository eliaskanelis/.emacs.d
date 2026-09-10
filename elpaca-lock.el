((anzu :source "elpaca-menu-lock-file" :recipe
       (:package "anzu" :fetcher github :repo "emacsorphanage/anzu"
		 :files
		 ("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
		  "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
		  "lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
		  "docs/*.texinfo"
		  (:exclude ".dir-locals.el" "test.el" "tests.el"
			    "*-test.el" "*-tests.el" "LICENSE"
			    "README*" "*-pkg.el"))
		 :source "MELPA" :id anzu :type git :protocol https
		 :inherit t :depth treeless :ref
		 "21cb5ab2295614372cb9f1a21429381e49a6255f"))
 (async :source "elpaca-menu-lock-file" :recipe
	(:package "async" :repo "jwiegley/emacs-async" :fetcher github
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
		  "4fdcb061a166e0d6ccc27d3829a28e04415ae825" :id async
		  :type git))
 (browse-at-remote :source "elpaca-menu-lock-file" :recipe
		   (:package "browse-at-remote" :repo
			     "eliaskanelis/browse-at-remote" :fetcher
			     github :files
			     ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			      "*.texinfo" "doc/dir" "doc/*.info"
			      "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			      "docs/dir" "docs/*.info" "docs/*.texi"
			      "docs/*.texinfo"
			      (:exclude ".dir-locals.el" "test.el"
					"tests.el" "*-test.el"
					"*-tests.el" "LICENSE"
					"README*" "*-pkg.el"))
			     :source "elpaca-menu-lock-file" :protocol
			     https :inherit t :depth treeless :host
			     github :ref
			     "6b16ad86da361cce07518f2469d11def5fd520ca"
			     :id browse-at-remote :type git))
 (compat :source "elpaca-menu-lock-file" :recipe
	 (:package "compat" :repo
		   ("https://github.com/emacs-compat/compat"
		    . "compat")
		   :tar nil :host gnu :files ("*" (:exclude ".git"))
		   :source "elpaca-menu-lock-file" :id compat :type
		   git :protocol https :inherit t :depth treeless :ref
		   "f0787bca0f7eae45e51fa752b46e38f49e09137e"))
 (cond-let
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
	     "3b88187fe067d4ca3dec3ef8a329b0ce18bdb356" :id cond-let
	     :type git))
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
		 "69e03917f6fd35e25b9a9dfd02df8ff3643f9227" :id crux
		 :type git))
 (dash :source "elpaca-menu-lock-file" :recipe
       (:package "dash" :fetcher github :repo "magnars/dash.el" :files
		 ("dash.el" "dash.texi") :source
		 "elpaca-menu-lock-file" :protocol https :inherit t
		 :depth treeless :ref
		 "d746dd9edcb67a108818beb0cdc78dc1cb466832" :id dash
		 :type git))
 (diff-hl :source "elpaca-menu-lock-file" :recipe
	  (:package "diff-hl" :fetcher github :repo "dgutov/diff-hl"
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
		    "0e1d464b48172a1f1e2f36103d812c9fc6387c4e" :id
		    diff-hl :type git))
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
		   "bbab62f01d45086b9098f6a0ab765282d9c7bc45" :id
		   dimmer :type git))
 (dockerfile-mode :source "elpaca-menu-lock-file" :recipe
		  (:package "dockerfile-mode" :fetcher github :repo
			    "spotify/dockerfile-mode" :files
			    ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			     "*.texinfo" "doc/dir" "doc/*.info"
			     "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			     "docs/dir" "docs/*.info" "docs/*.texi"
			     "docs/*.texinfo"
			     (:exclude ".dir-locals.el" "test.el"
				       "tests.el" "*-test.el"
				       "*-tests.el" "LICENSE"
				       "README*" "*-pkg.el"))
			    :source "MELPA" :id dockerfile-mode :type
			    git :protocol https :inherit t :depth
			    treeless :ref
			    "97733ce074b1252c1270fd5e8a53d178b66668ed"))
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
			  "adbd6325be5f84eafbc85efb5685452a5ba489bf"
			  :id doom-modeline :type git))
 (elpaca :source
   "elpaca-menu-lock-file" :recipe
   (:source nil :package "elpaca" :id elpaca :repo
	    "https://github.com/progfolio/elpaca.git" :ref
	    "5b0cbb19421ef20c140b46a7b1fb7d04240b53f6" :depth 1
	    :inherit ignore :files
	    (:defaults "elpaca-test.el" (:exclude "extensions"))
	    :build (:not elpaca-activate) :type git :protocol https))
 (elpaca-use-package :source "elpaca-menu-lock-file" :recipe
		     (:package "elpaca-use-package" :wait t :repo
			       "https://github.com/progfolio/elpaca.git"
			       :files
			       ("extensions/elpaca-use-package.el")
			       :main
			       "extensions/elpaca-use-package.el"
			       :build
			       (:not elpaca-source elpaca-build-docs)
			       :source "elpaca-menu-lock-file" :id
			       elpaca-use-package :type git :protocol
			       https :inherit t :depth treeless :ref
			       "5b0cbb19421ef20c140b46a7b1fb7d04240b53f6"))
 (emacsql :source "elpaca-menu-lock-file" :recipe
	  (:package "emacsql" :fetcher github :repo "magit/emacsql"
		    :files (:defaults "README.md" "sqlite") :source
		    "elpaca-menu-lock-file" :protocol https :inherit t
		    :depth treeless :ref
		    "d811bbefcb5e27841af55cae53aa939ba720de77" :id
		    emacsql :type git))
 (evil :source "elpaca-menu-lock-file" :recipe
       (:package "evil" :repo "emacs-evil/evil" :fetcher github :files
		 (:defaults "doc/build/texinfo/evil.texi"
			    (:exclude "evil-test-helpers.el"))
		 :source "MELPA" :id evil :type git :protocol https
		 :inherit t :depth treeless :ref
		 "6a3e1ddd04ac504a016590940d0af2a3361b9efd"))
 (evil-anzu :source "elpaca-menu-lock-file" :recipe
	    (:package "evil-anzu" :fetcher github :repo
		      "emacsorphanage/evil-anzu" :files
		      ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		       "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		       "doc/*.texinfo" "lisp/*.el" "docs/dir"
		       "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		       (:exclude ".dir-locals.el" "test.el" "tests.el"
				 "*-test.el" "*-tests.el" "LICENSE"
				 "README*" "*-pkg.el"))
		      :source "MELPA" :id evil-anzu :type git
		      :protocol https :inherit t :depth treeless :ref
		      "7309650425797420944075c9c1556c7c1ff960b3"))
 (evil-collection :source "elpaca-menu-lock-file" :recipe
		  (:package "evil-collection" :fetcher github :repo
			    "emacs-evil/evil-collection" :files
			    (:defaults "modes") :source "MELPA" :id
			    evil-collection :type git :protocol https
			    :inherit t :depth treeless :ref
			    "783c96b9901417cb8b6df63ab606387fa72dc922"))
 (evil-commentary :source "elpaca-menu-lock-file" :recipe
		  (:package "evil-commentary" :repo
			    "linktohack/evil-commentary" :fetcher
			    github :files
			    ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			     "*.texinfo" "doc/dir" "doc/*.info"
			     "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			     "docs/dir" "docs/*.info" "docs/*.texi"
			     "docs/*.texinfo"
			     (:exclude ".dir-locals.el" "test.el"
				       "tests.el" "*-test.el"
				       "*-tests.el" "LICENSE"
				       "README*" "*-pkg.el"))
			    :source "MELPA" :id evil-commentary :type
			    git :protocol https :inherit t :depth
			    treeless :ref
			    "c5945f28ce47644c828aac1f5f6ec335478d17fb"))
 (evil-goggles :source "elpaca-menu-lock-file" :recipe
	       (:package "evil-goggles" :repo "edkolev/evil-goggles"
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
			 :source "MELPA" :id evil-goggles :type git
			 :protocol https :inherit t :depth treeless
			 :ref
			 "34ca276a85f615d2b45e714c9f8b5875bcb676f3"))
 (evil-matchit :source "elpaca-menu-lock-file" :recipe
	       (:package "evil-matchit" :fetcher github :repo
			 "redguardtoo/evil-matchit" :files
			 ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			  "*.texinfo" "doc/dir" "doc/*.info"
			  "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			  "docs/dir" "docs/*.info" "docs/*.texi"
			  "docs/*.texinfo"
			  (:exclude ".dir-locals.el" "test.el"
				    "tests.el" "*-test.el"
				    "*-tests.el" "LICENSE" "README*"
				    "*-pkg.el"))
			 :source "MELPA" :id evil-matchit :type git
			 :protocol https :inherit t :depth treeless
			 :ref
			 "dd03aacd8602ffd2cd9b67d0072092f8d57d5e01"))
 (evil-numbers :source "elpaca-menu-lock-file" :recipe
	       (:package "evil-numbers" :repo "juliapath/evil-numbers"
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
			 :source "MELPA" :id evil-numbers :type git
			 :protocol https :inherit t :depth treeless
			 :ref
			 "616aff9e5cee012954756ed2715209fa90308cdf"))
 (evil-org :source "elpaca-menu-lock-file" :recipe
	   (:package "evil-org" :fetcher github :repo
		     "Somelauw/evil-org-mode" :files
		     ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		      "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		      "doc/*.texinfo" "lisp/*.el" "docs/dir"
		      "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		      (:exclude ".dir-locals.el" "test.el" "tests.el"
				"*-test.el" "*-tests.el" "LICENSE"
				"README*" "*-pkg.el"))
		     :source "MELPA" :id evil-org :type git :protocol
		     https :inherit t :depth treeless :ref
		     "b1f309726b1326e1a103742524ec331789f2bf94"))
 (evil-surround :source "elpaca-menu-lock-file" :recipe
		(:package "evil-surround" :repo
			  "emacs-evil/evil-surround" :fetcher github
			  :old-names (surround) :files
			  ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			   "*.texinfo" "doc/dir" "doc/*.info"
			   "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			   "docs/dir" "docs/*.info" "docs/*.texi"
			   "docs/*.texinfo"
			   (:exclude ".dir-locals.el" "test.el"
				     "tests.el" "*-test.el"
				     "*-tests.el" "LICENSE" "README*"
				     "*-pkg.el"))
			  :source "MELPA" :id evil-surround :type git
			  :protocol https :inherit t :depth treeless
			  :ref
			  "e6548372e8359ee55e67d73ca418314086011f1a"))
 (evil-visualstar :source "elpaca-menu-lock-file" :recipe
		  (:package "evil-visualstar" :repo
			    "bling/evil-visualstar" :fetcher github
			    :files
			    ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			     "*.texinfo" "doc/dir" "doc/*.info"
			     "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			     "docs/dir" "docs/*.info" "docs/*.texi"
			     "docs/*.texinfo"
			     (:exclude ".dir-locals.el" "test.el"
				       "tests.el" "*-test.el"
				       "*-tests.el" "LICENSE"
				       "README*" "*-pkg.el"))
			    :source "MELPA" :id evil-visualstar :type
			    git :protocol https :inherit t :depth
			    treeless :ref
			    "06c053d8f7381f91c53311b1234872ca96ced752"))
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
			  "351279272330cae6cecea941b0033a8dd8bcc4e8"
			  :id expand-region :type git))
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
	      "931b6d0667fe03e7bf1c6c282d6d8d7006143c52" :id f :type
	      git))
 (fzf :source "elpaca-menu-lock-file" :recipe
      (:package "fzf" :repo "bling/fzf.el" :fetcher github :files
		("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
		 "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
		 "lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
		 "docs/*.texinfo"
		 (:exclude ".dir-locals.el" "test.el" "tests.el"
			   "*-test.el" "*-tests.el" "LICENSE"
			   "README*" "*-pkg.el"))
		:source "elpaca-menu-lock-file" :protocol https
		:inherit t :depth treeless :ref
		"75060d81f4eea3f8088ac2a4a3a253c686b44d44" :id fzf
		:type git))
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
		    "a48768f85a655fe77b5f45c2880b420da1b1b9c3" :id
		    general :type git))
 (git-timemachine :source "elpaca-menu-lock-file" :recipe
		  (:package "git-timemachine" :fetcher codeberg :repo
			    "pidu/git-timemachine" :files
			    ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			     "*.texinfo" "doc/dir" "doc/*.info"
			     "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			     "docs/dir" "docs/*.info" "docs/*.texi"
			     "docs/*.texinfo"
			     (:exclude ".dir-locals.el" "test.el"
				       "tests.el" "*-test.el"
				       "*-tests.el" "LICENSE"
				       "README*" "*-pkg.el"))
			    :source "elpaca-menu-lock-file" :protocol
			    https :inherit t :depth treeless :ref
			    "d1346a76122595aeeb7ebb292765841c6cfd417b"
			    :id git-timemachine :type git))
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
			 "375c9f287dfad68829582c1e0a67d0c18119dab9"
			 :id golden-ratio :type git))
 (goto-chg :source "elpaca-menu-lock-file" :recipe
	   (:package "goto-chg" :repo "emacs-evil/goto-chg" :fetcher
		     github :files
		     ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		      "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		      "doc/*.texinfo" "lisp/*.el" "docs/dir"
		      "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		      (:exclude ".dir-locals.el" "test.el" "tests.el"
				"*-test.el" "*-tests.el" "LICENSE"
				"README*" "*-pkg.el"))
		     :source "MELPA" :id goto-chg :type git :protocol
		     https :inherit t :depth treeless :ref
		     "72f556524b88e9d30dc7fc5b0dc32078c166fda7"))
 (hl-todo :source "elpaca-menu-lock-file" :recipe
	  (:package "hl-todo" :repo "tarsius/hl-todo" :fetcher github
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
		    "527d545b8c2f36243194cbe4a8d0e6ac9d50e6a7" :id
		    hl-todo :type git))
 (ht :source "elpaca-menu-lock-file" :recipe
     (:package "ht" :fetcher github :repo "Wilfred/ht.el" :files
	       ("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
		"doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
		"lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
		"docs/*.texinfo"
		(:exclude ".dir-locals.el" "test.el" "tests.el"
			  "*-test.el" "*-tests.el" "LICENSE" "README*"
			  "*-pkg.el"))
	       :source "elpaca-menu-lock-file" :protocol https
	       :inherit t :depth treeless :ref
	       "1c49aad1c820c86f7ee35bf9fff8429502f60fef" :id ht :type
	       git))
 (llama :source "elpaca-menu-lock-file" :recipe
	(:package "llama" :fetcher github :repo "tarsius/llama" :files
		  ("llama.el" ".dir-locals.el") :source
		  "elpaca-menu-lock-file" :protocol https :inherit t
		  :depth treeless :ref
		  "cfea618f14bc8317f8e4947fe10000b229b9a447" :id llama
		  :type git))
 (magit :source "elpaca-menu-lock-file" :recipe
	(:package "magit" :fetcher github :repo "magit/magit" :files
		  ("lisp/magit*.el" "lisp/git-*.el" "docs/magit.texi"
		   "docs/AUTHORS.md" "LICENSE" ".dir-locals.el"
		   (:exclude "lisp/magit-section.el"))
		  :source "elpaca-menu-lock-file" :protocol https
		  :inherit t :depth treeless :ref
		  "9cb07d820d2b9ebbe9940e4d493293522d4e21d2" :id magit
		  :type git))
 (magit-section :source "elpaca-menu-lock-file" :recipe
		(:package "magit-section" :fetcher github :repo
			  "magit/magit" :files
			  ("lisp/magit-section.el"
			   "docs/magit-section.texi"
			   "magit-section-pkg.el")
			  :source "elpaca-menu-lock-file" :protocol
			  https :inherit t :depth treeless :ref
			  "9cb07d820d2b9ebbe9940e4d493293522d4e21d2"
			  :id magit-section :type git))
 (magit-todos :source "elpaca-menu-lock-file" :recipe
	      (:package "magit-todos" :fetcher github :repo
			"alphapapa/magit-todos" :files
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
			"7294a95580bddf7232f2d205efae312dc24c5f61" :id
			magit-todos :type git))
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
		       "c5d0139012d2a84f8040219b9aee17db4e145e5c" :id
		       marginalia :type git))
 (markdown-mode :source "elpaca-menu-lock-file" :recipe
		(:package "markdown-mode" :fetcher github :repo
			  "jrblevin/markdown-mode" :files
			  ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			   "*.texinfo" "doc/dir" "doc/*.info"
			   "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			   "docs/dir" "docs/*.info" "docs/*.texi"
			   "docs/*.texinfo"
			   (:exclude ".dir-locals.el" "test.el"
				     "tests.el" "*-test.el"
				     "*-tests.el" "LICENSE" "README*"
				     "*-pkg.el"))
			  :source "MELPA" :id markdown-mode :type git
			  :protocol https :inherit t :depth treeless
			  :ref
			  "76cb4ffecfdf95ee769e5cb4608e04202c3c1521"))
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
			  "1295604ef359b53f3ecb49dcc67ffcbbc1175e25"
			  :id monokai-theme :host github :type git))
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
		      "142890cfb46d9c374113b4b49021a4202033147b" :id
		      move-text :type git))
 (nerd-icons :source "elpaca-menu-lock-file" :recipe
	     (:package "nerd-icons" :repo
		       "rainstormstudio/nerd-icons.el" :fetcher github
		       :files (:defaults "data") :source
		       "elpaca-menu-lock-file" :protocol https
		       :inherit t :depth treeless :ref
		       "17faac7977242b470732efd417d3bcc8eb5a830e" :id
		       nerd-icons :type git))
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
			 "9bb4669400a300e9d8243916593d2455d4d63c26"
			 :id no-littering :type git))
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
		     "d2ccae56b442d9c5b06dd2481057abbd7eb82551" :id
		     olivetti :type git))
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
		      "5806e3f9401606d16962cffae68188c92deb1272" :id
		      orderless :type git))
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
		"c8286c97c0843d2ea3a50bc833e17dd9a1919d92" :id org
		:type git))
 (org-block-capf :source "elpaca-menu-lock-file" :recipe
		 (:source "elpaca-menu-lock-file" :protocol https
			  :inherit t :depth treeless :host github
			  :repo "xenodium/org-block-capf" :branch
			  "main" :package "org-block-capf" :ref
			  "080cfd2ed630a6739633b07a8ab6b896a1b5ef4a"
			  :id org-block-capf :type git))
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
			"767f55feb58b840a5a04eabfc3fbbf0d257c4792" :id
			org-bullets :type git))
 (org-roam :source "elpaca-menu-lock-file" :recipe
	   (:package "org-roam" :fetcher github :repo
		     "org-roam/org-roam" :files
		     (:defaults "extensions/*") :source
		     "elpaca-menu-lock-file" :protocol https :inherit
		     t :depth treeless :ref
		     "903bd4ec56d29247990d005ed9052c201e18b812" :id
		     org-roam :type git))
 (org-roam-ui :source "elpaca-menu-lock-file" :recipe
	      (:package "org-roam-ui" :fetcher github :repo
			"org-roam/org-roam-ui" :files
			(:defaults "out") :source
			"elpaca-menu-lock-file" :protocol https
			:inherit t :depth treeless :ref
			"2894dcbf56d2eca8d3cae2b1ae183f51724b5db6" :id
			org-roam-ui :type git))
 (pcre2el :source "elpaca-menu-lock-file" :recipe
	  (:package "pcre2el" :fetcher github :repo "joddie/pcre2el"
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
		    "b4d846d80dddb313042131cf2b8fbf647567e000" :id
		    pcre2el :type git))
 (popup :source "elpaca-menu-lock-file" :recipe
	(:package "popup" :fetcher github :repo
		  "auto-complete/popup-el" :files
		  ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		   "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		   "doc/*.texinfo" "lisp/*.el" "docs/dir"
		   "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		   (:exclude ".dir-locals.el" "test.el" "tests.el"
			     "*-test.el" "*-tests.el" "LICENSE"
			     "README*" "*-pkg.el"))
		  :source "elpaca-menu-lock-file" :protocol https
		  :inherit t :depth treeless :ref
		  "3afe431e9aa2e271aaf0412cbb50c733387e8ea4" :id popup
		  :type git))
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
	      "d7c04b84d03481a1ed62ee13dbe595224ccbe57c" :id s :type
	      git))
 (shift-number :source "elpaca-menu-lock-file" :recipe
	       (:package "shift-number" :fetcher codeberg :repo
			 "ideasman42/emacs-shift-number" :files
			 ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			  "*.texinfo" "doc/dir" "doc/*.info"
			  "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			  "docs/dir" "docs/*.info" "docs/*.texi"
			  "docs/*.texinfo"
			  (:exclude ".dir-locals.el" "test.el"
				    "tests.el" "*-test.el"
				    "*-tests.el" "LICENSE" "README*"
				    "*-pkg.el"))
			 :source "MELPA" :id shift-number :type git
			 :protocol https :inherit t :depth treeless
			 :ref
			 "52f4d32080cca50da0f88b2141d597827c7341cf"))
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
			"c14882c8599aec79a6e8ef2d06454254bb3e1e41" :id
			shrink-path :type git))
 (sideline :source "elpaca-menu-lock-file" :recipe
	   (:package "sideline" :repo "emacs-sideline/sideline"
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
		     "247cd6f6a0a841c5da20b3cc179d77c118641d66" :id
		     sideline :type git))
 (sideline-blame :source "elpaca-menu-lock-file" :recipe
		 (:package "sideline-blame" :repo
			   "emacs-sideline/sideline-blame" :fetcher
			   github :files
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
			   "1506c9877752745d187f8ff5e77e7400a0edcb3b"
			   :id sideline-blame :type git))
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
			 "0c17124cefddf2d50defcec5f2bd25fa6d1db756"
			 :id simple-httpd :type git))
 (transient :source "elpaca-menu-lock-file" :recipe
	    (:package "transient" :fetcher github :repo
		      "magit/transient" :files
		      ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		       "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		       "doc/*.texinfo" "lisp/*.el" "docs/dir"
		       "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		       (:exclude ".dir-locals.el" "test.el" "tests.el"
				 "*-test.el" "*-tests.el" "LICENSE"
				 "README*" "*-pkg.el"))
		      :source "elpaca-menu-lock-file" :protocol https
		      :inherit t :depth treeless :ref
		      "03c8ccc6aab24021787aada2be12d64cb1f436e8" :id
		      transient :type git))
 (vc-msg :source "elpaca-menu-lock-file" :recipe
	 (:package "vc-msg" :fetcher github :repo "redguardtoo/vc-msg"
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
		   "d55a128616a876936f085e5af486924062e57d66" :id
		   vc-msg :type git))
 (vertico :source "elpaca-menu-lock-file" :recipe
	  (:package "vertico" :repo "minad/vertico" :files
		    (:defaults "extensions/vertico-*.el") :fetcher
		    github :source "elpaca-menu-lock-file" :protocol
		    https :inherit t :depth treeless :ref
		    "8581ed12e9190005ea9afaef19f2a22951aa1bfb" :id
		    vertico :type git))
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
		      "2195e1247ecb04c30321702aa5f5618a51c329c5" :id
		      websocket :type git))
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
		      "38d4308d1143b61e4004b6e7a940686784e51500" :id
		      which-key :type git))
 (with-editor :source "elpaca-menu-lock-file" :recipe
	      (:package "with-editor" :fetcher github :repo
			"magit/with-editor" :files
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
			"5021ef6885381cf5b2852f7a3f67ca8c4be1dca2" :id
			with-editor :type git)))
