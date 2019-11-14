function [subset, corr_coe, corr_coe_max] = CBL_find_subset_low_corr_behaviors(corr_mat)
threshold = 0.65;

corr_mat = abs(corr_mat);

weak_corr_entry = corr_mat <= threshold;
rng('default');

for ini = 1:size(corr_mat,1)
%  for ini = 1
    for iter = 1:5000
        %node = ini;
        rng(iter);
        node = randperm(804,1);
        weak_connection = weak_corr_entry(node,:);
        %exclude_set = find(weak_connection == 0);
        explore_set = find(sum(~weak_connection,1) == 0);

        while(~isempty(explore_set))
            [curr_node,explore_set_update] = searching_node(node,explore_set,weak_corr_entry);
            explore_set = explore_set_update;
            node = curr_node;
        end
        subset{ini,iter} = node;
        corr_coe(ini,iter) = (sum(sum((corr_mat(node,node))))-length(node))./(length(node)*(length(node)-1));
        tmp = corr_mat(node,node);
        if(size(tmp,1)~=1)
            corr_coe_max(ini,iter) = max(tmp(tril(ones(size(tmp)),-1)==1));
        else
            corr_coe_max(ini,iter) = tmp;
        end
    end
end

end

function [curr_node,explore_set_update] = searching_node(node,explore_set,weak_corr_entry)
idx = randperm(length(explore_set),1);
curr_node = [node explore_set(idx)];
weak_connection = weak_corr_entry(curr_node,:);
%exclude_set = find(weak_connection == 0);
explore_set_update = find(sum(~weak_connection) == 0);

end
        
        
        
        
        

