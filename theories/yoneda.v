
Section Yoneda.

  Variable P : Type.
  Variable Hom : P -> P -> Type.
  Variable Comp : forall {p q r}, Hom q r -> Hom p q -> Hom p r.
  Variable Id : forall p, Hom p p.
  Variable Id_L : forall {p q} (f:Hom p q), Comp _ _ _ f (Id p) = f.
  Variable Id_R : forall {p q} (f:Hom p q), Comp _ _ _ (Id q) f = f.

Definition Y (p: P) := fun r => Hom r p.

Definition YHom (p q : P) := forall r, Y p r -> Y q r.

Definition YComp {p q r : P} (g: YHom q r) (f: YHom p q) : YHom p r :=
  fun r' k => g _ (f _ k).

Infix "°" := YComp (at level 55).

Definition YId (p: P) : YHom p p :=
  fun r' k => k.

Definition Yassoc p q r s (f : YHom p q) (g : YHom q r) (h : YHom r s)
           : (h ° g) ° f = h ° (g ° f) := eq_refl.

Definition YId_R p q (f : YHom p q)
           : YId _ ° f = f := eq_refl.

Definition YId_L p q (f : YHom p q)
           : f ° YId _  = f := eq_refl.

Definition Yoneda_embedding_l {p q : P} : Hom p q -> YHom p q :=
  fun f r k => Comp _ _ _ f k.

Definition Yoneda_embedding_r {p q : P} : YHom p q -> Hom p q :=
  fun k => k p (Id p).

Definition Yoneda_embedding_lr (p q : P) (f:Hom p q) :
  Yoneda_embedding_r (Yoneda_embedding_l f) = f := Id_L _ _ f.

End Yoneda.

Definition Yoneda_fun := forall
    (P : Type)
    (Hom : P -> P -> Type)
    (Comp : forall {p q r}, Hom q r -> Hom p q -> Hom p r)
    (Id : forall p, Hom p p)
    p q, YHom P Hom p q.


(* Require Import Parametricity. *)
(* Parametricity Yoneda_fun arity 2. *)

(* Here is the result, for those who don't have the plugin of Marc Lasson *)

Definition Yoneda_fun_R :=
fun
  H
   H0 : forall (P : Type) (Hom : P -> P -> Type),
        (forall p q r : P, Hom q r -> Hom p q -> Hom p r) ->
        (forall p : P, Hom p p) -> forall p q : P, YHom P Hom p q =>
forall (P₁ P₂ : Type) (P_R : P₁ -> P₂ -> Type) (Hom₁ : P₁ -> P₁ -> Type)
  (Hom₂ : P₂ -> P₂ -> Type)
  (Hom_R : forall (H1 : P₁) (H2 : P₂),
           P_R H1 H2 ->
           forall (H3 : P₁) (H4 : P₂),
           P_R H3 H4 -> Hom₁ H1 H3 -> Hom₂ H2 H4 -> Type)
  (Comp₁ : forall p q r : P₁, Hom₁ q r -> Hom₁ p q -> Hom₁ p r)
  (Comp₂ : forall p q r : P₂, Hom₂ q r -> Hom₂ p q -> Hom₂ p r),
(forall (p₁ : P₁) (p₂ : P₂) (p_R : P_R p₁ p₂) (q₁ : P₁)
   (q₂ : P₂) (q_R : P_R q₁ q₂) (r₁ : P₁) (r₂ : P₂)
   (r_R : P_R r₁ r₂) (H1 : Hom₁ q₁ r₁) (H2 : Hom₂ q₂ r₂),
 Hom_R q₁ q₂ q_R r₁ r₂ r_R H1 H2 ->
 forall (H3 : Hom₁ p₁ q₁) (H4 : Hom₂ p₂ q₂),
 Hom_R p₁ p₂ p_R q₁ q₂ q_R H3 H4 ->
 Hom_R p₁ p₂ p_R r₁ r₂ r_R (Comp₁ p₁ q₁ r₁ H1 H3) (Comp₂ p₂ q₂ r₂ H2 H4)) ->
forall (Id₁ : forall p : P₁, Hom₁ p p) (Id₂ : forall p : P₂, Hom₂ p p),
(forall (p₁ : P₁) (p₂ : P₂) (p_R : P_R p₁ p₂),
 Hom_R p₁ p₂ p_R p₁ p₂ p_R (Id₁ p₁) (Id₂ p₂)) ->
forall (p₁ : P₁) (p₂ : P₂) (p_R : P_R p₁ p₂) (q₁ : P₁)
  (q₂ : P₂) (q_R : P_R q₁ q₂),
(fun (P₁0 P₂0 : Type) (P_R0 : P₁0 -> P₂0 -> Type)
   (Hom₁0 : P₁0 -> P₁0 -> Type) (Hom₂0 : P₂0 -> P₂0 -> Type)
   (Hom_R0 : forall (H1 : P₁0) (H2 : P₂0),
             P_R0 H1 H2 ->
             forall (H3 : P₁0) (H4 : P₂0),
             P_R0 H3 H4 -> Hom₁0 H1 H3 -> Hom₂0 H2 H4 -> Type)
   (p₁0 : P₁0) (p₂0 : P₂0) (p_R0 : P_R0 p₁0 p₂0)
   (q₁0 : P₁0) (q₂0 : P₂0) (q_R0 : P_R0 q₁0 q₂0)
   (H1 : forall r : P₁0, Y P₁0 Hom₁0 p₁0 r -> Y P₁0 Hom₁0 q₁0 r)
   (H2 : forall r : P₂0, Y P₂0 Hom₂0 p₂0 r -> Y P₂0 Hom₂0 q₂0 r) =>
 forall (r₁ : P₁0) (r₂ : P₂0) (r_R : P_R0 r₁ r₂)
   (H3 : Y P₁0 Hom₁0 p₁0 r₁) (H4 : Y P₂0 Hom₂0 p₂0 r₂),
 (fun (P₁1 P₂1 : Type) (P_R1 : P₁1 -> P₂1 -> Type)
    (Hom₁1 : P₁1 -> P₁1 -> Type) (Hom₂1 : P₂1 -> P₂1 -> Type)
    (Hom_R1 : forall (H5 : P₁1) (H6 : P₂1),
              P_R1 H5 H6 ->
              forall (H7 : P₁1) (H8 : P₂1),
              P_R1 H7 H8 -> Hom₁1 H5 H7 -> Hom₂1 H6 H8 -> Type)
    (p₁1 : P₁1) (p₂1 : P₂1) (p_R1 : P_R1 p₁1 p₂1)
    (r₁0 : P₁1) (r₂0 : P₂1) (r_R0 : P_R1 r₁0 r₂0) =>
  Hom_R1 r₁0 r₂0 r_R0 p₁1 p₂1 p_R1) P₁0 P₂0 P_R0 Hom₁0 Hom₂0 Hom_R0 p₁0
   p₂0 p_R0 r₁ r₂ r_R H3 H4 ->
 (fun (P₁1 P₂1 : Type) (P_R1 : P₁1 -> P₂1 -> Type)
    (Hom₁1 : P₁1 -> P₁1 -> Type) (Hom₂1 : P₂1 -> P₂1 -> Type)
    (Hom_R1 : forall (H5 : P₁1) (H6 : P₂1),
              P_R1 H5 H6 ->
              forall (H7 : P₁1) (H8 : P₂1),
              P_R1 H7 H8 -> Hom₁1 H5 H7 -> Hom₂1 H6 H8 -> Type)
    (p₁1 : P₁1) (p₂1 : P₂1) (p_R1 : P_R1 p₁1 p₂1)
    (r₁0 : P₁1) (r₂0 : P₂1) (r_R0 : P_R1 r₁0 r₂0) =>
  Hom_R1 r₁0 r₂0 r_R0 p₁1 p₂1 p_R1) P₁0 P₂0 P_R0 Hom₁0 Hom₂0 Hom_R0 q₁0
   q₂0 q_R0 r₁ r₂ r_R (H1 r₁ H3) (H2 r₂ H4)) P₁ P₂ P_R Hom₁ Hom₂ Hom_R p₁
  p₂ p_R q₁ q₂ q_R (H P₁ Hom₁ Comp₁ Id₁ p₁ q₁)
  (H0 P₂ Hom₂ Comp₂ Id₂ p₂ q₂).

Axiom Yoneda_fun_param_thm : forall (f g:Yoneda_fun), Yoneda_fun_R f g.

Axiom fun_ext : forall A (B:A -> Type) (f g : forall a: A, B a),
    (forall x, f x = g x) -> f = g. 

Definition transport {A x y} (P:A -> Type) (p:x = y) (X:P y) : P x.
destruct p; exact X.
Defined.

Definition inv {A} (x y:A) (p:x = y) : y = x.
destruct p. reflexivity. 
Defined.

Notation "p '#' x " := (transport _ p x) (at level 55).

Definition Yoneda_fun_param (f:Yoneda_fun) (P : Type)
    (Hom : P -> P -> Type)
    (Comp : forall p q r, Hom q r -> Hom p q -> Hom p r)
    (Id : forall p, Hom p p)
    (p q : P) r k :
    f P Hom Comp Id p q r k = Comp r p q (f P Hom Comp Id p q p (Id _)) k.
  pose (f_R := Yoneda_fun_param_thm f
          (fun P Hom Comp Id p q r k => Comp r p q (f P Hom Comp Id p q p (Id _)) k)). 
   unfold Yoneda_fun_R in f_R. 
   specialize (f_R P P (fun x y => x = y) Hom Hom). simpl in f_R.
   specialize (f_R (fun x x' Hx y y' Hy f g => f =
   transport (fun X => Hom X _) Hx (transport (fun X => Hom _ X) Hy g))).
   assert (H_Comp : forall (p₁ p₂ : P) (p_R : p₁ = p₂) (q₁ q₂ : P) 
           (q_R : q₁ = q₂) (r₁ r₂ : P) (r_R : r₁ = r₂) 
           (H : Hom q₁ r₁) (H0 : Hom q₂ r₂),
         H =
         transport (fun X : P => Hom X r₁) q_R
           (transport (fun X : P => Hom q₂ X) r_R H0) ->
         forall (H1 : Hom p₁ q₁) (H2 : Hom p₂ q₂),
         H1 =
         transport (fun X : P => Hom X q₁) p_R
           (transport (fun X : P => Hom p₂ X) q_R H2) ->
         Comp p₁ q₁ r₁ H H1 =
         transport (fun X : P => Hom X r₁) p_R
           (transport (fun X : P => Hom p₂ X) r_R (Comp p₂ q₂ r₂ H0 H2))).
   intros. destruct p_R, q_R, r_R. simpl in *. destruct H1, H4. reflexivity.
   assert (H_Id : forall (p₁ p₂ : P) (p_R : p₁ = p₂),
         Id p₁ =
         transport (fun X : P => Hom X p₁) p_R
           (transport (fun X : P => Hom p₂ X) p_R (Id p₂))).
   intros. destruct p_R. reflexivity.
   exact (f_R Comp Comp H_Comp Id Id H_Id p p eq_refl q q eq_refl r r eq_refl k k eq_refl).
Defined. 

Definition Yoneda_embedding_rl (P : Type)
    (Hom : P -> P -> Type)
    (Comp : forall p q r, Hom q r -> Hom p q -> Hom p r)
    (Id : forall p, Hom p p)
    (p q : P) (f:Yoneda_fun) :
    Yoneda_embedding_l P Hom Comp (Yoneda_embedding_r P Hom Id (f P Hom Comp Id p q)) = (f P Hom Comp Id p q).
   refine (fun_ext _ _ _ _ _). intro r. 
   refine (fun_ext _ _ _ _ _). intro k.  
   unfold Yoneda_embedding_r, Yoneda_embedding_l.
   apply inv. exact (Yoneda_fun_param f P Hom Comp Id p q r k).
Defined.
