; SMT-LIBv2 description generated by Yosys 0.41+24 (git sha1 165791769, clang++ 14.0.0-1ubuntu1.1 -fPIC -Os)
; yosys-smt2-module tb_fft_module
(declare-sort |tb_fft_module_s| 0)
(declare-fun |tb_fft_module_is| (|tb_fft_module_s|) Bool)
; yosys-smt2-wire rst 1
(define-fun |tb_fft_module_n rst| ((state |tb_fft_module_s|)) Bool false)
(define-fun |tb_fft_module_a| ((state |tb_fft_module_s|)) Bool true)
(define-fun |tb_fft_module_u| ((state |tb_fft_module_s|)) Bool true)
(define-fun |tb_fft_module_i| ((state |tb_fft_module_s|)) Bool true)
(define-fun |tb_fft_module_h| ((state |tb_fft_module_s|)) Bool true)
(define-fun |tb_fft_module_t| ((state |tb_fft_module_s|) (next_state |tb_fft_module_s|)) Bool true) ; end of module tb_fft_module
; yosys-smt2-topmod tb_fft_module
; end of yosys output
