module LibLlama

using llama_cpp_jll
export llama_cpp_jll

using CEnum

mutable struct llama_context end

const llama_token = Cint

struct llama_token_data
    id::llama_token
    p::Cfloat
    plog::Cfloat
end

# typedef void ( * llama_progress_callback ) ( double progress , void * ctx )
const llama_progress_callback = Ptr{Cvoid}

struct llama_context_params
    n_ctx::Cint
    n_parts::Cint
    seed::Cint
    f16_kv::Bool
    logits_all::Bool
    vocab_only::Bool
    use_mlock::Bool
    embedding::Bool
    progress_callback::llama_progress_callback
    progress_callback_user_data::Ptr{Cvoid}
end

# no prototype is found for this function at llama.h:67:43, please use with caution
"""
    llama_context_default_params()


### Prototype
```c
struct llama_context_params llama_context_default_params();
```
"""
function llama_context_default_params()
    ccall((:llama_context_default_params, libllama), llama_context_params, ())
end

"""
    llama_init_from_file(path_model, params)


### Prototype
```c
struct llama_context * llama_init_from_file( const char * path_model, struct llama_context_params params);
```
"""
function llama_init_from_file(path_model, params)
    ccall((:llama_init_from_file, libllama), Ptr{llama_context}, (Ptr{Cchar}, llama_context_params), path_model, params)
end

"""
    llama_free(ctx)


### Prototype
```c
void llama_free(struct llama_context * ctx);
```
"""
function llama_free(ctx)
    ccall((:llama_free, libllama), Cvoid, (Ptr{llama_context},), ctx)
end

"""
    llama_model_quantize(fname_inp, fname_out, itype, qk)


### Prototype
```c
int llama_model_quantize( const char * fname_inp, const char * fname_out, int itype, int qk);
```
"""
function llama_model_quantize(fname_inp, fname_out, itype, qk)
    ccall((:llama_model_quantize, libllama), Cint, (Ptr{Cchar}, Ptr{Cchar}, Cint, Cint), fname_inp, fname_out, itype, qk)
end

"""
    llama_eval(ctx, tokens, n_tokens, n_past, n_threads)


### Prototype
```c
int llama_eval( struct llama_context * ctx, const llama_token * tokens, int n_tokens, int n_past, int n_threads);
```
"""
function llama_eval(ctx, tokens, n_tokens, n_past, n_threads)
    ccall((:llama_eval, libllama), Cint, (Ptr{llama_context}, Ptr{llama_token}, Cint, Cint, Cint), ctx, tokens, n_tokens, n_past, n_threads)
end

"""
    llama_tokenize(ctx, text, tokens, n_max_tokens, add_bos)


### Prototype
```c
int llama_tokenize( struct llama_context * ctx, const char * text, llama_token * tokens, int n_max_tokens, bool add_bos);
```
"""
function llama_tokenize(ctx, text, tokens, n_max_tokens, add_bos)
    ccall((:llama_tokenize, libllama), Cint, (Ptr{llama_context}, Ptr{Cchar}, Ptr{llama_token}, Cint, Bool), ctx, text, tokens, n_max_tokens, add_bos)
end

"""
    llama_n_vocab(ctx)


### Prototype
```c
int llama_n_vocab(struct llama_context * ctx);
```
"""
function llama_n_vocab(ctx)
    ccall((:llama_n_vocab, libllama), Cint, (Ptr{llama_context},), ctx)
end

"""
    llama_n_ctx(ctx)


### Prototype
```c
int llama_n_ctx (struct llama_context * ctx);
```
"""
function llama_n_ctx(ctx)
    ccall((:llama_n_ctx, libllama), Cint, (Ptr{llama_context},), ctx)
end

"""
    llama_n_embd(ctx)


### Prototype
```c
int llama_n_embd (struct llama_context * ctx);
```
"""
function llama_n_embd(ctx)
    ccall((:llama_n_embd, libllama), Cint, (Ptr{llama_context},), ctx)
end

"""
    llama_get_logits(ctx)


### Prototype
```c
float * llama_get_logits(struct llama_context * ctx);
```
"""
function llama_get_logits(ctx)
    ccall((:llama_get_logits, libllama), Ptr{Cfloat}, (Ptr{llama_context},), ctx)
end

"""
    llama_get_embeddings(ctx)


### Prototype
```c
float * llama_get_embeddings(struct llama_context * ctx);
```
"""
function llama_get_embeddings(ctx)
    ccall((:llama_get_embeddings, libllama), Ptr{Cfloat}, (Ptr{llama_context},), ctx)
end

"""
    llama_token_to_str(ctx, token)


### Prototype
```c
const char * llama_token_to_str(struct llama_context * ctx, llama_token token);
```
"""
function llama_token_to_str(ctx, token)
    ccall((:llama_token_to_str, libllama), Ptr{Cchar}, (Ptr{llama_context}, llama_token), ctx, token)
end

# no prototype is found for this function at llama.h:129:27, please use with caution
"""
    llama_token_bos()


### Prototype
```c
llama_token llama_token_bos();
```
"""
function llama_token_bos()
    ccall((:llama_token_bos, libllama), llama_token, ())
end

# no prototype is found for this function at llama.h:130:27, please use with caution
"""
    llama_token_eos()


### Prototype
```c
llama_token llama_token_eos();
```
"""
function llama_token_eos()
    ccall((:llama_token_eos, libllama), llama_token, ())
end

"""
    llama_sample_top_p_top_k(ctx, last_n_tokens_data, last_n_tokens_size, top_k, top_p, temp, repeat_penalty)


### Prototype
```c
llama_token llama_sample_top_p_top_k( struct llama_context * ctx, const llama_token * last_n_tokens_data, int last_n_tokens_size, int top_k, double top_p, double temp, double repeat_penalty);
```
"""
function llama_sample_top_p_top_k(ctx, last_n_tokens_data, last_n_tokens_size, top_k, top_p, temp, repeat_penalty)
    ccall((:llama_sample_top_p_top_k, libllama), llama_token, (Ptr{llama_context}, Ptr{llama_token}, Cint, Cint, Cdouble, Cdouble, Cdouble), ctx, last_n_tokens_data, last_n_tokens_size, top_k, top_p, temp, repeat_penalty)
end

"""
    llama_print_timings(ctx)


### Prototype
```c
void llama_print_timings(struct llama_context * ctx);
```
"""
function llama_print_timings(ctx)
    ccall((:llama_print_timings, libllama), Cvoid, (Ptr{llama_context},), ctx)
end

"""
    llama_reset_timings(ctx)


### Prototype
```c
void llama_reset_timings(struct llama_context * ctx);
```
"""
function llama_reset_timings(ctx)
    ccall((:llama_reset_timings, libllama), Cvoid, (Ptr{llama_context},), ctx)
end

"""
    llama_print_system_info()


### Prototype
```c
const char * llama_print_system_info(void);
```
"""
function llama_print_system_info()
    ccall((:llama_print_system_info, libllama), Ptr{Cchar}, ())
end

const LLAMA_FILE_VERSION = 1

const LLAMA_FILE_MAGIC = 0x67676d66

const LLAMA_FILE_MAGIC_UNVERSIONED = 0x67676d6c

# exports
const PREFIXES = ["llama_", "LLAMA_", "ggml_", "GGML_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
