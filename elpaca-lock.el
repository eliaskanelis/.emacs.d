((aio :source "elpaca-menu-lock-file" :recipe
      (:package "aio" :fetcher github :repo "skeeto/emacs-aio" :files
		("aio.el" "README.md" "UNLICENSE") :source "MELPA" :id
		aio :type git :protocol https :inherit t :depth
		treeless :ref
		"a20c99aafef021b77b0a00735659142d4cf49682"))
 (anzu :source "elpaca-menu-lock-file" :recipe
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
		  :source "MELPA" :id async :type git :protocol https
		  :inherit t :depth treeless :ref
		  "4fdcb061a166e0d6ccc27d3829a28e04415ae825"))
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
			     :source "MELPA" :id browse-at-remote
			     :host github :type git :protocol https
			     :inherit t :depth treeless :ref
			     "6b16ad86da361cce07518f2469d11def5fd520ca"))
 (cape :source "elpaca-menu-lock-file" :recipe
       (:package "cape" :repo "minad/cape" :fetcher github :files
		 ("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
		  "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
		  "lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
		  "docs/*.texinfo"
		  (:exclude ".dir-locals.el" "test.el" "tests.el"
			    "*-test.el" "*-tests.el" "LICENSE"
			    "README*" "*-pkg.el"))
		 :source "MELPA" :id cape :type git :protocol https
		 :inherit t :depth treeless :ref
		 "50bc6187daf9af9df1a802fcbbd91fe4b952fc69"))
 (compat :source "elpaca-menu-lock-file" :recipe
	 (:package "compat" :repo
		   ("https://github.com/emacs-compat/compat"
		    . "compat")
		   :tar "31.1.0.0" :host gnu :files
		   ("*" (:exclude ".git")) :source "GNU ELPA" :id
		   compat :type git :protocol https :inherit t :depth
		   treeless :ref
		   "90880f81419577e1d3f68424d2a3adf31e6d663e"))
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
	     :source "MELPA" :id cond-let :type git :protocol https
	     :inherit t :depth treeless :ref
	     "09292a77001434f59ab55c775dec2b98cb18d028"))
 (consult :source "elpaca-menu-lock-file" :recipe
	  (:package "consult" :repo "minad/consult" :fetcher github
		    :files
		    ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		     "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		     "doc/*.texinfo" "lisp/*.el" "docs/dir"
		     "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		     (:exclude ".dir-locals.el" "test.el" "tests.el"
			       "*-test.el" "*-tests.el" "LICENSE"
			       "README*" "*-pkg.el"))
		    :source "MELPA" :id consult :type git :protocol
		    https :inherit t :depth treeless :ref
		    "a64569f377b8bc0f62e1d2ae0f3ee48ba4a7cc1c"))
 (corfu :source "elpaca-menu-lock-file" :recipe
	(:package "corfu" :repo "minad/corfu" :files
		  (:defaults "extensions/corfu-*.el") :fetcher github
		  :source "MELPA" :id corfu :type git :protocol https
		  :inherit t :depth treeless :ref
		  "b468efac023dda39332acc943edc9895c80b5a6f"))
 (crux :source "elpaca-menu-lock-file" :recipe
       (:package "crux" :fetcher github :repo "bbatsov/crux" :files
		 ("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
		  "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
		  "lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
		  "docs/*.texinfo"
		  (:exclude ".dir-locals.el" "test.el" "tests.el"
			    "*-test.el" "*-tests.el" "LICENSE"
			    "README*" "*-pkg.el"))
		 :source "MELPA" :id crux :type git :protocol https
		 :inherit t :depth treeless :ref
		 "e769fe4a40813c8b1d1d869acbfee2323d2ed182"))
 (dash :source "elpaca-menu-lock-file" :recipe
       (:package "dash" :fetcher github :repo "magnars/dash.el" :files
		 ("dash.el" "dash.texi") :source "MELPA" :id dash
		 :type git :protocol https :inherit t :depth treeless
		 :ref "d746dd9edcb67a108818beb0cdc78dc1cb466832"))
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
		    :source "MELPA" :id diff-hl :type git :protocol
		    https :inherit t :depth treeless :ref
		    "8dfb5c27ea43b8c7ac1c008bb97090ad4f059285"))
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
		   :source "MELPA" :id dimmer :type git :protocol
		   https :inherit t :depth treeless :ref
		   "bbab62f01d45086b9098f6a0ab765282d9c7bc45"))
 (dirvish :source "elpaca-menu-lock-file" :recipe
	  (:package "dirvish" :fetcher github :repo
		    "alexluigit/dirvish" :files
		    (:defaults "extensions/*.el") :source "MELPA" :id
		    dirvish :type git :protocol https :inherit t
		    :depth treeless :ref
		    "bf164ee21e128837ede59be03836a9900c4a41be"))
 (docker :source "elpaca-menu-lock-file" :recipe
	 (:package "docker" :fetcher github :repo "Silex/docker.el"
		   :files
		   ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		    "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		    "doc/*.texinfo" "lisp/*.el" "docs/dir"
		    "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		    (:exclude ".dir-locals.el" "test.el" "tests.el"
			      "*-test.el" "*-tests.el" "LICENSE"
			      "README*" "*-pkg.el"))
		   :source "MELPA" :id docker :type git :protocol
		   https :inherit t :depth treeless :ref
		   "08b9ae67f01431b3b07e7181388a08f3faba6824"))
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
			  :source "MELPA" :id doom-modeline :type git
			  :protocol https :inherit t :depth treeless
			  :ref
			  "c46dba3358010ecc025774fbae0db9695299cbf2"))
 (editorconfig :source "elpaca-menu-lock-file" :recipe
	       (:package "editorconfig" :fetcher github :repo
			 "editorconfig/editorconfig-emacs" :old-names
			 (editorconfig-core editorconfig-fnmatch)
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
			 :source "MELPA" :id editorconfig :type git
			 :protocol https :inherit t :depth treeless
			 :ref
			 "b18fcf7fdea1ce84b7fdc60360ad8016b5c00d79"))
 (elpaca :source
   "elpaca-menu-lock-file" :recipe
   (:source "Init file" :package "elpaca" :id elpaca :repo
	    "https://github.com/progfolio/elpaca.git" :ref
	    "7763ede8babd238b7a9a5835833ef4f4bdc4e53e" :depth 1
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
			       :source "Elpaca extensions" :id
			       elpaca-use-package :type git :protocol
			       https :inherit t :depth treeless :ref
			       "7763ede8babd238b7a9a5835833ef4f4bdc4e53e"))
 (emacsql :source "elpaca-menu-lock-file" :recipe
	  (:package "emacsql" :fetcher github :repo "magit/emacsql"
		    :files (:defaults "README.md" "sqlite") :source
		    "MELPA" :id emacsql :type git :protocol https
		    :inherit t :depth treeless :ref
		    "7a4c607912c8fdd1fca4def4915d68f43b12d4da"))
 (embark :source "elpaca-menu-lock-file" :recipe
	 (:package "embark" :repo "oantolin/embark" :fetcher github
		   :files ("embark.el" "embark-org.el" "embark.texi")
		   :source "MELPA" :id embark :type git :protocol
		   https :inherit t :depth treeless :ref
		   "87e53827cf6659dcc4ac4e54be9af34aeca44f6e"))
 (embark-consult :source "elpaca-menu-lock-file" :recipe
		 (:package "embark-consult" :repo "oantolin/embark"
			   :fetcher github :files
			   ("embark-consult.el") :source "MELPA" :id
			   embark-consult :type git :protocol https
			   :inherit t :depth treeless :ref
			   "87e53827cf6659dcc4ac4e54be9af34aeca44f6e"))
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
			    "a24e38cebd7a474423898fae7f58ddfd98d87ace"))
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
			    "2b804e317700896116e88ae751df4a36ac8c3934"))
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
			  :source "MELPA" :id expand-region :type git
			  :protocol https :inherit t :depth treeless
			  :ref
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
	      :source "MELPA" :id f :type git :protocol https :inherit
	      t :depth treeless :ref
	      "931b6d0667fe03e7bf1c6c282d6d8d7006143c52"))
 (fzf :source "elpaca-menu-lock-file" :recipe
      (:package "fzf" :repo "bling/fzf.el" :fetcher github :files
		("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
		 "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
		 "lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
		 "docs/*.texinfo"
		 (:exclude ".dir-locals.el" "test.el" "tests.el"
			   "*-test.el" "*-tests.el" "LICENSE"
			   "README*" "*-pkg.el"))
		:source "MELPA" :id fzf :type git :protocol https
		:inherit t :depth treeless :ref
		"75060d81f4eea3f8088ac2a4a3a253c686b44d44"))
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
		    :source "MELPA" :id general :type git :protocol
		    https :inherit t :depth treeless :ref
		    "a48768f85a655fe77b5f45c2880b420da1b1b9c3"))
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
			    :source "MELPA" :id git-timemachine :type
			    git :protocol https :inherit t :depth
			    treeless :ref
			    "d1346a76122595aeeb7ebb292765841c6cfd417b"))
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
			 :source "MELPA" :id golden-ratio :type git
			 :protocol https :inherit t :depth treeless
			 :ref
			 "375c9f287dfad68829582c1e0a67d0c18119dab9"))
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
	  (:package "hl-todo" :fetcher github :repo "tarsius/hl-todo"
		    :files
		    ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		     "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		     "doc/*.texinfo" "lisp/*.el" "docs/dir"
		     "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		     (:exclude ".dir-locals.el" "test.el" "tests.el"
			       "*-test.el" "*-tests.el" "LICENSE"
			       "README*" "*-pkg.el"))
		    :source "MELPA" :id hl-todo :type git :protocol
		    https :inherit t :depth treeless :ref
		    "d25aa5a2e78f70331de2b3455d8ef85bd945356b"))
 (ht :source "elpaca-menu-lock-file" :recipe
     (:package "ht" :fetcher github :repo "Wilfred/ht.el" :files
	       ("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
		"doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
		"lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
		"docs/*.texinfo"
		(:exclude ".dir-locals.el" "test.el" "tests.el"
			  "*-test.el" "*-tests.el" "LICENSE" "README*"
			  "*-pkg.el"))
	       :source "MELPA" :id ht :type git :protocol https
	       :inherit t :depth treeless :ref
	       "1c49aad1c820c86f7ee35bf9fff8429502f60fef"))
 (indent-bars :source "elpaca-menu-lock-file" :recipe
	      (:package "indent-bars" :repo
			("https://github.com/jdtsmith/indent-bars"
			 . "indent-bars")
			:tar "1.0.1" :host gnu :files
			("*" (:exclude ".git" "LICENSE")) :source
			"GNU ELPA" :id indent-bars :type git :protocol
			https :inherit t :depth treeless :ref
			"7733b4b8e1fbd69dc38940000e6eea7516ca2dbc"))
 (llama :source "elpaca-menu-lock-file" :recipe
	(:package "llama" :fetcher github :repo "tarsius/llama" :files
		  ("llama.el" ".dir-locals.el") :source "MELPA" :id
		  llama :type git :protocol https :inherit t :depth
		  treeless :ref
		  "6850d0c91b629da14fdff2300c222289d1a0029a"))
 (magit :source "elpaca-menu-lock-file" :recipe
	(:package "magit" :fetcher github :repo "magit/magit" :files
		  ("lisp/magit*.el" "lisp/git-*.el" "docs/magit.texi"
		   "docs/AUTHORS.md" "LICENSE" ".dir-locals.el"
		   ("githooks" "githooks/*")
		   ("git-hooks" "git-hooks/*")
		   (:exclude "lisp/magit-section.el"))
		  :source "MELPA" :id magit :type git :protocol https
		  :inherit t :depth treeless :ref
		  "58a469820bc3dc388f0193e3024147fb55a6c98f"))
 (magit-section :source "elpaca-menu-lock-file" :recipe
		(:package "magit-section" :fetcher github :repo
			  "magit/magit" :files
			  ("lisp/magit-section.el"
			   "docs/magit-section.texi"
			   "magit-section-pkg.el")
			  :source "MELPA" :id magit-section :type git
			  :protocol https :inherit t :depth treeless
			  :ref
			  "58a469820bc3dc388f0193e3024147fb55a6c98f"))
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
			:source "MELPA" :id magit-todos :type git
			:protocol https :inherit t :depth treeless
			:ref
			"7294a95580bddf7232f2d205efae312dc24c5f61"))
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
		       :source "MELPA" :id marginalia :type git
		       :protocol https :inherit t :depth treeless :ref
		       "381af583d2530796b9955ff2fe0cba3ad3119943"))
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
			  "1d22840d588be29aa57eca36f28a32bede331550"))
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
			  :source "MELPA" :id monokai-theme :host
			  github :branch "master" :type git :protocol
			  https :inherit t :depth treeless :ref
			  "4c892a3e73aa856f9eb212b5d47d73c5ec9f689d"))
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
		      :source "MELPA" :id move-text :type git
		      :protocol https :inherit t :depth treeless :ref
		      "142890cfb46d9c374113b4b49021a4202033147b"))
 (nerd-icons :source "elpaca-menu-lock-file" :recipe
	     (:package "nerd-icons" :repo
		       "rainstormstudio/nerd-icons.el" :fetcher github
		       :files (:defaults "data") :source "MELPA" :id
		       nerd-icons :type git :protocol https :inherit t
		       :depth treeless :ref
		       "63e76023274e9d4806f3d84f8f3b69b7b63bbfb9"))
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
			 :source "MELPA" :id no-littering :type git
			 :protocol https :inherit t :depth treeless
			 :ref
			 "ca39a217864e8320db9a6e8f07ff58d76c2f7e8a"))
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
		     :source "MELPA" :id olivetti :type git :protocol
		     https :inherit t :depth treeless :ref
		     "d2ccae56b442d9c5b06dd2481057abbd7eb82551"))
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
		      :source "MELPA" :id orderless :type git
		      :protocol https :inherit t :depth treeless :ref
		      "3d2c2e6468ddf51e69c78e8212e5fd9006d2ce8a"))
 (org :source "elpaca-menu-lock-file" :recipe
      (:package "org" :host github :repo "emacsmirror/org" :autoloads
		"org-loaddefs.el" :depth treeless :build
		((:not elpaca-build-autoloads)
		 (:before elpaca-build-link elpaca-menu-org--build))
		:files
		(:defaults ("etc/styles/" "etc/styles/*" "doc/*.texi"))
		:source "Org" :id org :type git :protocol https
		:inherit t :ref
		"a20d0f6d54711eef022fe50baf111b2b4e0898a8"))
 (org-block-capf :source "elpaca-menu-lock-file" :recipe
		 (:source "Init file" :package "org-block-capf" :id
			  org-block-capf :host github :repo
			  "xenodium/org-block-capf" :branch "main"
			  :type git :protocol https :inherit t :depth
			  treeless :ref
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
			:source "MELPA" :id org-bullets :type git
			:protocol https :inherit t :depth treeless
			:ref
			"767f55feb58b840a5a04eabfc3fbbf0d257c4792"))
 (org-roam :source "elpaca-menu-lock-file" :recipe
	   (:package "org-roam" :fetcher github :repo
		     "org-roam/org-roam" :files
		     (:defaults "extensions/*") :source "MELPA" :id
		     org-roam :type git :protocol https :inherit t
		     :depth treeless :ref
		     "903bd4ec56d29247990d005ed9052c201e18b812"))
 (org-roam-ui :source "elpaca-menu-lock-file" :recipe
	      (:package "org-roam-ui" :fetcher github :repo
			"org-roam/org-roam-ui" :files
			(:defaults "out") :source "MELPA" :id
			org-roam-ui :type git :protocol https :inherit
			t :depth treeless :ref
			"2894dcbf56d2eca8d3cae2b1ae183f51724b5db6"))
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
		    :source "MELPA" :id pcre2el :type git :protocol
		    https :inherit t :depth treeless :ref
		    "b4d846d80dddb313042131cf2b8fbf647567e000"))
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
		  :source "MELPA" :id popup :type git :protocol https
		  :inherit t :depth treeless :ref
		  "3afe431e9aa2e271aaf0412cbb50c733387e8ea4"))
 (s :source "elpaca-menu-lock-file" :recipe
    (:package "s" :fetcher github :repo "magnars/s.el" :files
	      ("*.el" "*.el.in" "dir" "*.info" "*.texi" "*.texinfo"
	       "doc/dir" "doc/*.info" "doc/*.texi" "doc/*.texinfo"
	       "lisp/*.el" "docs/dir" "docs/*.info" "docs/*.texi"
	       "docs/*.texinfo"
	       (:exclude ".dir-locals.el" "test.el" "tests.el"
			 "*-test.el" "*-tests.el" "LICENSE" "README*"
			 "*-pkg.el"))
	      :source "MELPA" :id s :type git :protocol https :inherit
	      t :depth treeless :ref
	      "d7c04b84d03481a1ed62ee13dbe595224ccbe57c"))
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
			:source "MELPA" :id shrink-path :type git
			:protocol https :inherit t :depth treeless
			:ref
			"c14882c8599aec79a6e8ef2d06454254bb3e1e41"))
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
		     :source "MELPA" :id sideline :type git :protocol
		     https :inherit t :depth treeless :ref
		     "247cd6f6a0a841c5da20b3cc179d77c118641d66"))
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
			   :source "MELPA" :id sideline-blame :type
			   git :protocol https :inherit t :depth
			   treeless :ref
			   "1506c9877752745d187f8ff5e77e7400a0edcb3b"))
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
			 :source "MELPA" :id simple-httpd :type git
			 :protocol https :inherit t :depth treeless
			 :ref
			 "0c17124cefddf2d50defcec5f2bd25fa6d1db756"))
 (tablist :source "elpaca-menu-lock-file" :recipe
	  (:package "tablist" :fetcher github :repo
		    "emacsorphanage/tablist" :files
		    ("*.el" "*.el.in" "dir" "*.info" "*.texi"
		     "*.texinfo" "doc/dir" "doc/*.info" "doc/*.texi"
		     "doc/*.texinfo" "lisp/*.el" "docs/dir"
		     "docs/*.info" "docs/*.texi" "docs/*.texinfo"
		     (:exclude ".dir-locals.el" "test.el" "tests.el"
			       "*-test.el" "*-tests.el" "LICENSE"
			       "README*" "*-pkg.el"))
		    :source "MELPA" :id tablist :type git :protocol
		    https :inherit t :depth treeless :ref
		    "01f065e387ffe6b7a41f180f257cd12551c7a9c2"))
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
		      :source "MELPA" :id transient :type git
		      :protocol https :inherit t :depth treeless :ref
		      "c886106bd506c4629ece352732f735657605cddb"))
 (treesit-auto :source "elpaca-menu-lock-file" :recipe
	       (:package "treesit-auto" :fetcher github :repo
			 "renzmann/treesit-auto" :files
			 ("*.el" "*.el.in" "dir" "*.info" "*.texi"
			  "*.texinfo" "doc/dir" "doc/*.info"
			  "doc/*.texi" "doc/*.texinfo" "lisp/*.el"
			  "docs/dir" "docs/*.info" "docs/*.texi"
			  "docs/*.texinfo"
			  (:exclude ".dir-locals.el" "test.el"
				    "tests.el" "*-test.el"
				    "*-tests.el" "LICENSE" "README*"
				    "*-pkg.el"))
			 :source "MELPA" :id treesit-auto :type git
			 :protocol https :inherit t :depth treeless
			 :ref
			 "3106c739c2a84bec2cb671997fe074e5dd5dd967"))
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
		   :source "MELPA" :id vc-msg :type git :protocol
		   https :inherit t :depth treeless :ref
		   "d55a128616a876936f085e5af486924062e57d66"))
 (vertico :source "elpaca-menu-lock-file" :recipe
	  (:package "vertico" :repo "minad/vertico" :files
		    (:defaults "extensions/vertico-*.el") :fetcher
		    github :source "MELPA" :id vertico :type git
		    :protocol https :inherit t :depth treeless :ref
		    "c60d80215d19b4b36c0ba49599b6815ed35f2ac1"))
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
		      :source "MELPA" :id websocket :type git
		      :protocol https :inherit t :depth treeless :ref
		      "2195e1247ecb04c30321702aa5f5618a51c329c5"))
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
		      :source "MELPA" :id which-key :type git
		      :protocol https :inherit t :depth treeless :ref
		      "38d4308d1143b61e4004b6e7a940686784e51500"))
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
			:source "MELPA" :id with-editor :type git
			:protocol https :inherit t :depth treeless
			:ref
			"3c390146741be401ff2e78e337707efd4bdec506")))
